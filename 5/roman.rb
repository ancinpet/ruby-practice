# frozen_string_literal: true

require_relative 'roman_int_module'
require_relative 'roman_string_module'

ROMAN_TO_INT =
  {
    i: 1,
    v: 5,
    x: 10,
    l: 50,
    c: 100,
    d: 500,
    m: 1000
  }.freeze

INT_TO_ROMAN =
  [
    [1, 'I'],
    [4, 'IV'],
    [5, 'V'],
    [9, 'IX'],
    [10, 'X'],
    [40, 'XL'],
    [50, 'L'],
    [90, 'XC'],
    [100, 'C'],
    [400, 'CD'],
    [500, 'D'],
    [900, 'CM'],
    [1000, 'M']
  ].freeze

# My implementation
class Roman
  include Comparable
  attr_reader :value

  def initialize(val)
    @value = val if val.is_a? Integer
    @value = to_arabic(val) if val.is_a? String

    raise ArgumentError, 'Roman can only be initialized from String or Integer' unless @value
    raise ArgumentError, 'Roman only supports argument range 1 - 1000' unless @value >= 1 && @value <= 1000
  end

  def to_arabic(val)
    # Split each symbol to array and convert to numbers, otherwise throw
    char_map = val.split('').map do |c|
      ROMAN_TO_INT[c.downcase.to_sym] || (raise ArgumentError, 'Roman representation contains unknown symbol')
    end
    # For each number in array, check if next number is bigger and if it is, return negative
    # If we are at the end of the array, do not modify
    # If I understood correctly, next is like return from a block
    char_map.map.with_index do |num, index|
      next (char_map[index + 1] > num ? -num : num) unless char_map[index + 1].nil?

      num
    end.sum
  end

  def to_roman # rubocop:disable Metrics/MethodLength
    result = ''
    index = INT_TO_ROMAN.size - 1
    number = @value
    while number.positive?
      div = number / INT_TO_ROMAN[index][0]
      number %= INT_TO_ROMAN[index][0]
      while div.positive?
        result += (INT_TO_ROMAN[index][1])
        div -= 1
      end
      index -= 1
    end
    result
  end

  def <=>(other)
    to_i <=> other.to_i
  end

  def +(other)
    Roman.new(to_i + other.to_i)
  end

  def *(other)
    Roman.new(to_i * other.to_i)
  end

  def /(other)
    raise ZeroDivisionError, 'Cannot divide by zero' if other.zero?

    Roman.new(to_i / other.to_i)
  end

  def -(other)
    result = to_i - other.to_i
    raise ArgumentError, 'Result of subtraction cannot be non-positive number.' unless result.positive?

    Roman.new(result)
  end

  def coerce(other)
    [other, to_i]
  end

  def to_int
    @value
  end

  def to_i
    @value
  end

  def to_s
    to_roman
  end

  def zero?
    @value.zero?
  end
end
