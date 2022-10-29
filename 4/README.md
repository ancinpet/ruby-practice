https://courses.fit.cvut.cz/NI-RUB/lectures/04/task.html

Example usage (ostruct required for testing same behaviour):
<pre>
require 'ostruct'

def __test__(struct)
  p struct.neverused
  p struct.never_used
  struct.test = 4
  p struct.test
  struct.test = 6
  p struct.test
  struct.test = 8
  p struct.test
  struct.test_rest = 10
  p struct.test_rest
  struct.test_12_rest = 12
  p struct.test_12_rest
  p struct.delete_field('test_rest')
  p struct.test_rest
  p struct.to_h
  hasher = (struct.to_h { |name, value| [name.to_s, value.to_s] })
  p hasher
  hasher.delete('test')
  p struct.to_h
  enum = struct.each_pair
  enum.each { |n, v| p(n, v) }
  struct.each_pair { |n, v| p(n, v) }
end

__test__(OpenStruct.new)
p '------------------'
__test__(MyStruct.new)
p '------------------'
a = MyStruct.new
b = MyStruct.new
p(a == b)
a.test = 5
p(a == b)
p(a.storage)
hash = { "country" => "Australia", :capital => "Canberra" }
a = MyStruct.new(hash)
p(a)
p(a.country)
p(a.capital)
a.capital = 'potatoland'
p(a.capital)
</pre>