# frozen_string_literal: true

require_relative './grid'
require_relative './cell'
# Parse string for 9x9 sudoku game
class StringParser
  # Static methods will follow
  class << self
    # Return true if passed object
    # is supported by this loader
    def supports?(arg)
      arg.respond_to?(:to_s) and arg.to_s.length == 9 * 9 and !arg.to_s.scan(/([0-9]|\.){81}/).empty?
    end

    # Return Grid object when finished
    # parsing
    def load(arg)
      return unless supports?(arg)

      grid = Grid.new(9)
      for pos in 0...arg.length
        grid.game[pos / 9][pos % 9] = Cell.new(arg[pos].chr.to_i, 9)
      end
      grid
    end
  end
end
