# Calculates and displays shortest path from any square to any square

module Knight

	def self.move_knight(start, goal)
		Node.new(start).tap do |series|
			series.calculate_moves(goal)
		end
	end

	class Node
		attr_reader :location, :parent, :moves, :valid_moves
		
		def initialize(location, parent=nil)
			@location = location
			@parent = parent
			@moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
			@valid_moves = find_valid_moves(location)
		end

		def calculate_moves(goal)
			final_node = self.create_move_path(goal)
			path = document_path(final_node)
			display_path(path)
		end

		def create_move_path(goal, level=nil)
			next_level = []
			level = [self] if level == nil
			level.each do |node|
				node.valid_moves.each do |move|
					next_level << Node.new(move, node)
				end
			end
			final = next_level.find { |node| node.location == goal }
			final.nil? ? create_move_path(goal, next_level) : final
		end

		def document_path(node)
			path = []
			until node.nil?
				path << node.location
				node = node.parent
			end
			path
		end
		
		def display_path(path)
			path.reverse!
			puts "You went from #{path.first} to #{path.last} in #{path.size - 1} moves:"
			path.each {|move| p move }
		end

		def find_valid_moves(location)
			valid_moves = []
			@moves.each do |move|
				potential = [location[0] + move[0], location[1] + move[1]]
				valid_moves << potential if on_board?(potential)
			end
			valid_moves
		end

		def on_board?(move)
			move[0].between?(1, 8) && move[1].between?(1, 8) ? true : false
		end
	end
end

Knight.move_knight([1, 1], [8, 8]) # =>
# You went from [1, 1] to [8, 8] in 6 moves:
# [1, 1]
# [2, 3]
# [3, 5]
# [4, 7]
# [5, 5]
# [6, 7]
# [8, 8]
