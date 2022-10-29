# frozen_string_literal: true

(1..100).each do |i|
  print 'Fizz' if (i % 3).zero?
  print ' ' if (i % 5).zero? && (i % 3).zero?
  print 'Buzz' if (i % 5).zero?
  print i unless (i % 5).zero? || (i % 3).zero?
  print ', ' unless i == 100
end
