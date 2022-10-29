# frozen_string_literal: true

# Represent single number in sudoku grid which could
# have 9 possible values unless a values is already
# assigned
class Cell
  attr_accessor :value
  attr_reader :possible

  def initialize(value, dimension)
    @value = 0
    @value = value if value.to_i.positive?
    @possible = []
    @possible = (1..dimension).to_a if @value.zero?
  end

  def possible_at(index)
    return nil if index.negative? || index >= @possible.length

    @possible[index]
  end

  def pick
    return false if @possible.empty?

    @value = @possible.sample
    @possible = []
    true
  end

  # true when value was already assigned
  def filled?
    @value.positive?
  end

  def filled
    return 1 if filled?

    @value
  end

  def serialize
    @value.to_s
  end

  # number of possible values at this position
  def num_possible
    return -1 if filled?

    @possible.size
  end

  def possibilities
    @possible
  end

  def possibilities_count
    @possible.length
  end

  def excludes(array)
    return if filled?

    @possible -= array

    return unless @possible.length == 1

    @value = @possible[0]
    @possible = []
  end

  # exclude possibility
  # return true if number was deleted
  def exclude(num)
    return true if !filled? && @possible.delete(num)

    false
  end

  def to_i
    @value
  end
end
