# frozen_string_literal: true

# Compatibility with Roman
class Integer
  def roman
    Roman.new(self).to_s
  end

  def to_rom
    Roman.new(self)
  end
end
