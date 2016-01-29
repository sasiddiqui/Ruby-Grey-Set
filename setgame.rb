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
			puts @table[i][0] + @table[i][1] + @table[i][2] + @table[i][3]
		end
	end

	def draw_cards
		@table << @deck.take(3)
	end

	def set_exists?
		isSet = false
		for i in (0..9)
			for j in (1..11)
				for k in (2..12)
					isSet = true if check_set? [@table[i],@table[j],@table[k]] 
				end
			end
		end
	end

	def input_set(player)
		puts "Input the index of three cards in a set:"
		card1 = gets.chomp.to_i
		card2 = gets.chomp.to_i
		card3 = gets.chomp.to_i
		cards = [@table[card1],@table[card2],@table[card3]]
		if check_set? then
			update_score playername 1
			puts "Yes, that is a set."
			@table.delete_at card1
			@table.delete_at card2
			@table.delete_at card3
			draw_cards if @table.size < 12
		else
			update_score playername -1
			puts "Sorry that is not a set."
		end
	end

	def match?(attributes)
		len = attributes.uniq.length
		len == 1 or len == 3
	end

	def check_set?(cards)
		matched = true
		for i in 0..3 do
			card_attributes = [cards[0][i], cards[1][i], cards[2][i]]
			matched = false unless match? card_attributes 
		end
	end

	def update_score(player, points)
		player.score += points
	end
end

class Player
	def initialize(name)
		@name = name
		@score = 0
	end
end


puts "Welcome to the game of Set!"
puts "How many players?"
numPlayers = gets.chomp.to_i
players = []
for i in (1..numPlayers) do
	puts "What is the name of player " + i.to_s + "?"
	name = gets
	puts "Welcome, " + name + "!"
	players[i] = Player.new(name)
end


game = SetGame.new

while game.deck.size > 0 do
	game.print_deck
	if game.set_exists? then
		puts "Buzz in if you found a set"
		playerNum = gets.chomp.to_i
		puts "Ok, " + players[playerNum].name + ". What is your set?"
		game.input_set players[playerNum]
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
