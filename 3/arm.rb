# frozen_string_literal: true

# Arm module
class Arm
  attr_reader :length, :type, :score
  SCORES = { poker: 1, slasher: 3, grabber: 5 }.freeze

  def initialize(length, type)
    @score = SCORES[type] || (raise 'Type must be poker, slasher or grabber!')
    raise 'Length must be positive!' unless length.positive?

    @length = length
    @type = type
  end
end
