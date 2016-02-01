# Set game


class SetGame

	@@colors = ['red', 'green', 'blue']
	@@numbers = ['one', 'two', 'three']
	@@shapes = ['oval', 'squiggle', 'diamond']
	@@fills = ['solid', 'stripes', 'outlined']

	

	def initialize
		@deck = []

		for color in @@colors do
			for shape in @@shapes do
				for fill in @@fills do
					for number in @@numbers do
						@deck.push [color, shape, fill, number]
					end
				end
			end
		end

		@deck.shuffle!
		@table = @deck.take 12
		@deck = @deck.drop 12
	end

	def print_deck

		for i in (0..11) do
			puts "#{i}. " + @table[i][0] + "     \t" + @table[i][1] + "     \t" + @table[i][2] + "     \t" + @table[i][3]
		end
	end

	def print_scores(numPlayers, players)
		puts "Score Board\n"
		for i in (1..numPlayers) do
			puts players[i].name + ": " + players[i].get_score.to_s
		end
		puts "\n"
	end

	def deck_size
		@deck.size
	end

	def draw_cards
		new_cards = @deck.take(3)
		@table.concat new_cards
	end

	def set_exists?
		isSet = false
		for i in (0..11) do
			for j in (0..11) do
				for k in (0..11) do
					cards = []
					cards.push(@table[i])
					cards.push(@table[j])
					cards.push(@table[k])
					isSet = true if check_set? cards
				end
			end
		end
	end

	def input_set(player)
		cards = []
		card_index = []
		puts "Input the number of each card individually:"
		card_index.push(gets.chomp.to_i)
		card_index.push(gets.chomp.to_i)
		card_index.push(gets.chomp.to_i)
		cards = [@table[card_index[0]],@table[card_index[1]],@table[card_index[2]]]
		if check_set?(cards) then
			update_score(player, 1)
			puts "Yes, that is a set."
			@table.delete_at card_index.pop
			@table.delete_at card_index.pop
			@table.delete_at card_index.pop
			draw_cards if @table.size < 12
		else
			update_score(player, -1)
			puts "Sorry, that is not a set."
		end
	end

	def check_set?(cards)
		unique = 0
		card_attributes = []
		isSet = true
		for i in (0..3) do
			matched = false
			card_attributes.push(cards.at(0).at(i))
			card_attributes.push(cards.at(1).at(i)) 
			card_attributes.push(cards.at(2).at(i))
			#if the three attributes match, or if they are all unique, these attributes "match"
			if((card_attributes.uniq.length == 1)||(card_attributes.uniq.length == 3))
				matched = true
			end
			#If we find a category of attribute where there is not a match, then these cards are not a set
			if !matched then
				isSet = false
			end
			card_attributes = []
		end
		return isSet
	end

	def update_score(player, points)
		player.set_score points
	end
end

class Player
	def initialize(name)
		@name = name
		@score = 0
	end

	def name
		@name
	end
	def get_score
		@score
	end
	def set_score(points)
		@score += points
	end
end


puts "Welcome to the game of Set!"
puts "How many players?"
numPlayers = gets.chomp.to_i
players = []
for i in (1..numPlayers) do
	puts"What is the name of player " + i.to_s + "?"
	name = gets.chomp
	puts "Welcome, #{name}!"
	players[i] = Player.new(name)
end

puts "Lets get started, here's the cards on the table:"
game = SetGame.new
while game.deck_size > 0 do
	game.print_scores numPlayers, players
	game.print_deck
	if game.set_exists? then
		puts "Buzz in if you found a set"
		playerNum = gets.chomp.to_i
		if playerNum > numPlayers or playerNum < 1 then
			puts "Sorry, that is not the number of a player!"
		else
		puts "Ok, " + players[playerNum].name + ". What is your set?"
		game.input_set players[playerNum]
		end
	else
		puts "Looks like there's no sets on the table. I'll draw some more cards."
		game.draw_cards
	end
end
max = 0
for i in numPlayers do 
	if players[i].score > max then
		max = players[i].score 
		index = i 
	end
end

puts "With a score of " + players[index].score.to_s + ", The winner is....."
puts players[index].name + "!"
