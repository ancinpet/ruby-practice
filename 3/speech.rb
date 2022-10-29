# frozen_string_literal: true

# Speech module
module Speech
  def can_say(text)
    raise 'Cannot speak nonsense!' unless text.respond_to?(:to_s)
  end

  def can_speak
    raise 'I am mute!' unless respond_to?(:speak)
  end

  def caesar(text, amount)
    char_list = text.to_s.chars.map(&:ord)
    moved = char_list.map { |c| c + amount }
    moved.map(&:chr).join
  end

  def shout(text)
    can_speak
    can_say(text)

    speak(text.to_s.upcase)
  end

  def whisper(text)
    can_speak
    can_say(text)

    speak(text.to_s.downcase)
  end

  def secret(text)
    can_speak
    can_say(text)

    encrypted = caesar(text, 3)
    speak(encrypted)
  end
end
