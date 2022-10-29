# frozen_string_literal: true

require 'English'
require_relative './cell'

# Contains sudoku game board
class Grid
  include Enumerable
  @loaded = false

  attr_accessor :game
  attr_accessor :dimension

  # Create Sudoku game grid of given dimension
  def initialize(dimension)
    @loaded = true
    @game = Array.new(dimension) { Array.new(dimension) }
    @dimension = dimension
  end

  def print_row(_width, block_index, row_index)
    result = ''
    for pos in 0...rows
      cell_num = value((block_index * 3) + row_index, pos)
      result += ' '
      result += cell_num.zero? ? ' ' : cell_num.to_s
      result += ' '
      result += '|' if ((pos + 1) % 3).zero? && pos != rows - 1
    end
    result
  end

  def print_row_block(width, block_index)
    row = ''
    row += print_row(width, block_index, 0) + $INPUT_RECORD_SEPARATOR
    row += print_row(width, block_index, 1) + $INPUT_RECORD_SEPARATOR
    row += print_row(width, block_index, 2) + $INPUT_RECORD_SEPARATOR
    row += '---------+---------+---------' + $INPUT_RECORD_SEPARATOR
    row
  end

  # Return string with game board in a console friendly format
  def to_s(width = 3)
    result = '---------+---------+---------' + $INPUT_RECORD_SEPARATOR
    result += print_row_block(width, 0)
    result += print_row_block(width, 1)
    result += print_row_block(width, 2)
    result
  end

  # First element in the sudoku grid
  def first
    @game[0][0]
  end

  # Last element in the sudoku grid
  def last
    @game[@game.length - 1][@game.length - 1]
  end

  # Return value at given position
  def value(x_cord, y_cord)
    @game[x_cord][y_cord].to_i
  end

  def row(x_cord)
    @game[x_cord].map(&:to_i)
  end

  def col(y_cord)
    @game.transpose[y_cord].map(&:to_i)
  end

  def block(index)
    result = []
    for x in 0...3
      for y in 0...3
        result.append(@game[((index / 3) * 3) + x][((index % 3) * 3) + y])
      end
    end
    result
  end

  def pass_grid
    exclude_rows
    exclude_cols
    exclude_blocks
  end

  def exclude_rows
    for x_cord in 0...@dimension
      exclude_row(x_cord)
    end
  end

  def exclude_cols
    for y_cord in 0...@dimension
      exclude_col(y_cord)
    end
  end

  def exclude_blocks
    for block_cord in 0...@dimension
      exclude_block(block_cord)
    end
  end

  def exclude_row(x_cord)
    current_row = row(x_cord)
    row_elems(x_cord).each { |cell| cell.excludes(current_row) }
  end

  def exclude_col(y_cord)
    current_col = col(y_cord)
    col_elems(y_cord).each { |cell| cell.excludes(current_col) }
  end

  def exclude_block(block_cord)
    currect_block_ref = block(block_cord)
    current_block = currect_block_ref.map(&:to_i)
    currect_block_ref.each { |cell| cell.excludes(current_block) }
  end

  # Marks number +z+ which shouldn't be at position [x, y]
  def exclude(x_cord, y_cord, z_cord)
    @game[x_cord][y_cord].exclude(z_cord)
  end

  # True when there is already a number
  def filled?(x_cord, y_cord)
    @game[x_cord][y_cord].filled?
  end

  # True when no game was loaded
  def empty?
    @loaded
  end

  # Yields elements in given row
  def row_elems(x_cord)
    return enum_for(:row_elems, x_cord) unless block_given?

    @game[x_cord].each { |e| yield e }
  end

  # Yields elements in given column
  def col_elems(y_cord)
    return enum_for(:col_elems, y_cord) unless block_given?

    @game.transpose[y_cord].each { |e| yield e }
  end

  # Yields elements from block which is
  # containing element at given position
  def block_elems(x_cord, y_cord)
    return enum_for(:block_elems, x_cord, y_cord) unless block_given?

    block_from_cords(x_cord, y_cord).each { |e| yield e }
  end

  # With one argument return row, with 2, element
  # at given position
  def [](*args)
    if args.length == 2
      value(args[0], args[1])
    elsif args.length == 1
      row(args[0])
    end
  end

  # With one argument sets row, with 2 element
  def []=(*args)
    if args.length == 3
      @game[args[0]][args[1]] = Cell.new(args[2], @dimension)
    elsif args.length == 2
      @game[args[0]] = args[1].map { |value| Cell.new(value, @dimension) }
    end
  end

  # Return number of missing numbers in grid
  def missing
    (@dimension * @dimension) - @game.flatten.map(&:filled).reduce(:+)
  end

  # Number of filled cells
  def filled
    @game.flatten.map(&:filled).reduce(:+)
  end

  # Number of rows in this sudoku
  def rows
    @dimension
  end

  # Number of columns in this sudoku
  def cols
    @dimension
  end

  # Iterates over all elements, left to right, top to bottom
  def each
    return enum_for(:each) unless block_given?

    @game.each { |r| r.each { |e| yield e } }
  end

  def block_from_cords(x_cord, y_cord)
    result = []
    for x in 0...3
      for y in 0...3
        result.append(@game[((x_cord / 3) * 3) + x][((y_cord / 3) * 3) + y])
      end
    end
    result
  end

  def row_invalid(x_cord)
    row_elems(x_cord).group_by(&:to_i).any? { |key, cell| cell.length > 1 && key.positive? }
  end

  def rows_valid?
    for x_cord in 0...@dimension
      return false if row_invalid(x_cord)
    end

    true
  end

  def col_invalid(y_cord)
    col_elems(y_cord).group_by(&:to_i).any? { |key, cell| cell.length > 1 && key.positive? }
  end

  def cols_valid?
    for y_cord in 0...@dimension
      return false if col_invalid(y_cord)
    end

    true
  end

  def block_invalid(index)
    block(index).group_by(&:to_i).any? { |key, cell| cell.length > 1 && key.positive? }
  end

  def blocks_valid?
    for index in 0...@dimension
      return false if block_invalid(index)
    end

    true
  end

  # Return true if no filled number break sudoku rules
  def valid?
    return false if @game.flatten.any? { |cell| cell.to_i > @dimension || cell.to_i.negative? }

    return false unless rows_valid? && cols_valid? && blocks_valid?

    true
  end

  def valid_solved?
    valid? && missing.zero?
  end

  # Serialize grid values to a one line string
  def solution
    @game.flatten.map(&:serialize).reduce(:+)
  end
end
