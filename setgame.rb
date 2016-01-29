
<<<<<<< HEAD
=======
# Set game


class SetGame

	@@colors = ['red', 'green', 'blue']
	@@numbers = ['one', 'two', 'three']
	@@shapes = ['oval', 'squiggle', 'diamond']
	@@fills = ['solid', 'stripes', 'outlined']

	@deck = []

	def initialize

		for color in @@colors do
			for shape in @@shapes do
				for fill in @@fills do
					for number in @@numbers do
						@deck << [color, shape, fill, number]
					end
				end
			end
		end

		@deck.shuffle!
		@table = @deck.take 12
		@deck = @deck.drop 12

	end

	def print_deck

	end

	def input_set

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

	def update_score(playername)
		playername.score += 1
	end

end

class Player
	@@no_of_players=0
	def initialize(name)
		@name = name
		@score = 0
	end
end

end
>>>>>>> 2e35db89c2a7fbf03a24a830f2df503543825e61
