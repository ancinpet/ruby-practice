#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'thor'

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

# @author Petr Ancinec
class RomanConverter < Thor
  map %w[--arabic -a] => :__make_arabic
  map %w[--roman -r] => :__make_roman

  desc '--arabic -a', 'Get arabic representation'
  # Converts a roman string or an integer into the arabic representation.
  # If the conversion is not possible, 'Invalid Argument' is printed into the console.
  #
  # == Parameters:
  # argument::
  #   String (roman number) or Integer to be converted into the arabic representation.
  #
  # == Returns:
  # An Integer representing the number in the arabic format to stdout
  #
  def __make_arabic(argument)
    puts(make_arabic(argument))
  end

  desc '--roman -r', 'Get roman representation'
  # Converts a roman string or an integer into the roman representation.
  # If the conversion is not possible, 'Invalid Argument' is printed into the console.
  #
  # == Parameters:
  # argument::
  #   String (roman number) or Integer to be converted into the roman representation.
  #
  # == Returns:
  # A String representing the number in the roman format to stdout
  #
  def __make_roman(argument)
    puts(make_roman(argument))
  end

  no_commands do # rubocop:disable Metrics/BlockLength
    def make_arabic(argument)
      value = 0
      begin
        value = get_arabic(argument)
      rescue StandardError
        return 'Invalid Argument'
      end
      print_arabic(value)
    end

    def make_roman(argument)
      value = 0
      begin
        value = get_arabic(argument)
      rescue StandardError
        return 'Invalid Argument'
      end
      print_roman(value)
    end

    def self.exit_on_failure?
      true
    end

    def get_arabic(argument)
      if argument.to_i.to_s == argument.to_s
        argument.to_i
      else
        to_arabic(argument)
      end
    end

    def print_arabic(value)
      if value >= 1 && value <= 1000
        value
      else
        'Invalid Argument Range'
      end
    end

    def print_roman(value)
      if value >= 1 && value <= 1000
        to_roman(value)
      else
        'Invalid Argument Range'
      end
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

    def to_roman(val) # rubocop:disable Metrics/MethodLength
      result = ''
      index = INT_TO_ROMAN.size - 1
      while val.positive?
        div = val / INT_TO_ROMAN[index][0]
        val %= INT_TO_ROMAN[index][0]
        while div.positive?
          result += (INT_TO_ROMAN[index][1])
          div -= 1
        end
        index -= 1
      end
      result
    end
  end
end
