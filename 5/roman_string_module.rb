# frozen_string_literal: true

# Compatibility with Roman
class String
  def number
    Roman.new(self).to_int
  end

  def to_rom
    Roman.new(self)
  end
end
