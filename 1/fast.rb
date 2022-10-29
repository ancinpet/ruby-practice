# frozen_string_literal: true

(1..100).each do |i|
  if (i % 5).zero? && (i % 3).zero?
    print 'Fizz Buzz'
  elsif (i % 3).zero?
    print 'Fizz'
  elsif (i % 5).zero?
    print 'Buzz'
  else
    print i
  end
  print ', ' unless i == 100
end
