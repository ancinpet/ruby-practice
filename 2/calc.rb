# frozen_string_literal: true

# My calculator
class Calculator
  def initialize(val = 0)
    @value = val
    @name = 'Calcy'
  end

  def add(*rest)
    rest.each do |val|
      @value += val
    end
    self
  end

  def subtract(val)
    @value -= val
    self
  end

  def multiply(val)
    @value *= val
    self
  end

  def divide(val)
    raise 'Cannot divide by zero!' if val.zero?

    @value = if (@value % val).zero?
               @value / val
             else
               @value / val.to_f
             end
    self
  end

  def result
    @value
  end

  def name
    @name.upcase
  end

  attr_writer :name

  def self.number?(val)
    val.is_a? Numeric
  end

  def self.extreme(param, arr)
    if param == :max
      arr.max
    elsif param == :min
      arr.min
    end
  end
end
