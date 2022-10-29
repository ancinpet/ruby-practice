# frozen_string_literal: true

require_relative './grid'
require_relative './string_parser'

# Basic sudoku solver
class Sudoku
  PARSERS = [StringParser].freeze
  attr_accessor :grid

  EXCLUDE = proc do |enum, val|
    enum.each do |e|
      e.exclude(val)
    end
  end

  def initialize(game)
    @grid = load(game)
  end

  def reduce_pass(grid)
    old_sol = grid.solution
    loop do
      grid.pass_grid
      new_sol = grid.solution
      break if new_sol == old_sol

      old_sol = new_sol
    end
  end

  # Solves sudoku and returns 2D Grid
  def solve
    raise 'invalid game given' unless @grid.valid?

    # This is good enough to solve regular tests
    reduce_pass(@grid)
    return @grid if solved?

    # Advanced tests get here
    @grid = black_magic
    @grid
  end

  def solution
    @grid.solution
  end

  # Return true when there is no missing number
  def solved?
    !@grid.nil? && @grid.missing.zero?
  end

  protected

  def load(game)
    PARSERS.each do |p|
      return p.load(game) if p.supports?(game)
    end
    raise "input '#{game}' is not supported yet"
  end

  #                    .
  #          /^\     .
  #     /\   "V"
  #    /__\   I      O  o
  #   //..\\  I     .
  #   \].`[/  I
  #   /l\/j\  (]    .  O
  #  /. ~~ ,\/I          .
  #  \\L__j^\/I       o
  #   \/--v}  I     o   .
  #   |    |  I   _________
  #   |    |  I c(`       ')o
  #   |    l  I   \.     ,/
  # _/j  L l\_!  _//^---^\\_
  # "The code is in a huge block not because I am lazy, but because it has to run like C"
  # Solves complex sudoku in 1 <> infinity seconds, on average around 5 seconds
  BEST_FIRST_CYCLES = 13
  TOP_ELEMENTS_FRACTION = 8

  # Straight up guesses the solution, requires very lucky PRNG to be efficient
  def black_magic
    grid = StringParser.load(@grid.solution)
    reduce_pass(grid)

    # Fake it till you make it
    until grid.valid_solved?
      # Deep copy?
      grid = StringParser.load(@grid.solution)
      reduce_pass(grid)
      guess_fields = []

      # Best first random search couple of times
      BEST_FIRST_CYCLES.times do
        missing_fields = []
        for x in 0...grid.dimension
          for y in 0...grid.dimension
            cell = grid.game[x][y]
            missing_fields.append([x, y]) if cell.value.zero?
          end
        end

        guess_fields = []
        for f in 0...missing_fields.length
          x_cord = missing_fields[f][0]
          y_cord = missing_fields[f][1]
          guess_fields.append(grid.game[x_cord][y_cord])
        end
        guess_fields = guess_fields.sort_by(&:possibilities_count)

        best_length = guess_fields.length / TOP_ELEMENTS_FRACTION
        best_length = best_length > 4 ? best_length : 4
        for c in 0...best_length
          break if guess_fields[c].nil?
          break unless guess_fields[c].pick

          reduce_pass(grid)
          return grid if grid.valid_solved?
        end
      end

      # Bruteforce the remaining cells
      missing_fields = []
      for x in 0...grid.dimension
        for y in 0...grid.dimension
          cell = grid.game[x][y]
          missing_fields.append([x, y]) if cell.value.zero?
        end
      end

      guess_fields = []
      for f in 0...missing_fields.length
        x_cord = missing_fields[f][0]
        y_cord = missing_fields[f][1]
        guess_fields.append(grid.game[x_cord][y_cord])
      end
      guess_fields = guess_fields.sort_by(&:possibilities_count)
      guess_fields = guess_fields.shuffle

      for random_cell in guess_fields
        break unless random_cell.pick

        reduce_pass(grid)
        return grid if grid.valid_solved?
      end
    end

    grid
  end
end
