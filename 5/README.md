https://courses.fit.cvut.cz/NI-RUB/lectures/05/task.html

Example usage:

<pre>
roman = Roman.new(4)
p(1 + roman)
p(roman + 1)

p(10 - roman)
p(roman - 1)

p(2 * roman)
p(roman * 2)

p(8 / roman)
p(roman / 2)

second = Roman.new(6)
p(roman + second)
p(second - roman)

p([Roman.new(1), Roman.new(3), Roman.new(9)].sum)

p(Roman.new(4) == 4)
p(Roman.new(5) > Roman.new(1))

p([Roman.new(1), Roman.new(3), Roman.new(9)].min)

p(roman.to_i)

p((1..100).first(roman))

p(roman.to_s)

p('IV'.number)
p('IV'.to_rom)
p(5.to_rom)
</pre>