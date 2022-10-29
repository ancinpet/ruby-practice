https://courses.fit.cvut.cz/NI-RUB/lectures/03/task.html

Score is updated when arms are called for improved efficiency, because the operator<=> gets called often (for example when sorting) so it has to be fast

Example usage:

r = Robot.new('bot')

r.speak('gibb')

r.shout('gibb')

r.whisper('GIBB')

r.secret('abcdefghijkmlnopqrstuvwxyz')

r.secret('potato')

r.shout(9999)


grabber1 = Arm.new(3, :grabber)

grabber2 = Arm.new(5, :grabber)

poker1 = Arm.new(7, :poker)

poker2 = Arm.new(11, :poker)

slasher1 = Arm.new(13, :slasher)

slasher2 = Arm.new(17, :slasher)


r.add_arms(grabber1)

p(r.score)

r.add_arms(grabber2).add_arms(poker1, poker2)

p(r.score)

r.add_arms(slasher1, slasher2)

p(r.score)


s = Robot.new('tob')

s.add_arms(grabber1, poker1, poker2)

p(s.score)


puts(s < r)

r.introduce

s.introduce

