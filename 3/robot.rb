# frozen_string_literal: true

require_relative 'speech'
require_relative 'arm'

# My robot
class Robot
  include Speech
  include Comparable
  attr_reader :name, :arms, :score

  def initialize(name)
    @name = name
    @arms = []
    @score = 0
  end

  def <=>(other)
    @score <=> other.score
  end

  def speak(text)
    puts(text)
  end

  def update_score
    avg_len = arms.map(&:length).inject(0, &:+).fdiv(arms.length)
    arm_score = arms.map(&:score).inject(0, &:+)
    @score = avg_len + arm_score
  end

  def add_arms(*to_add)
    @arms.push(*to_add)
    update_score
    self
  end

  def arm_types
    arms.group_by(&:type).map { |k, v| "#{k} (#{v.length})" }
  end

  def introduce
    puts("Hello, my name is #{name}!")
    puts("I have #{arms.length} arm#{arms.length > 1 ? 's' : ''} - #{arm_types.join(', ')}.")
  end
end
