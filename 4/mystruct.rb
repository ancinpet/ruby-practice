# frozen_string_literal: true

# My implementation
class MyStruct
  def initialize(to_copy = nil)
    @map = {}
    copy_values(to_copy) if to_copy
  end

  def copy_values(to_copy)
    to_copy.each_pair do |k, v|
      create_getter_setter(k)
      @map[k.to_sym] = v
    end
  end

  def storage
    @map
  end
  # Change to map would break the struct, better version than comparing copies (to_h)
  protected :storage

  def to_h(&block)
    if block
      @map.map(&block).to_h
    else
      @map.dup
    end
  end

  def eql?(other)
    return false unless other.is_a?(MyStruct)

    storage.eql?(other.storage)
  end

  def ==(other)
    return false unless other.is_a?(MyStruct)

    to_h == other.to_h
  end

  def create_getter_setter(name)
    name = name.to_sym
    return if @map.key?(name)

    define_singleton_method(name) { @map[name] }
    define_singleton_method("#{name}=") { |value| @map[name] = value }
  end

  def []=(name, value)
    @map[name.to_sym] = value
  end

  def method_missing(name, *args)
    if name.to_s =~ /\w+=\z/
      name = name[0..-2]
      create_getter_setter(name)
      @map[name.to_sym] = args[0]
    elsif args.length.zero? && name.to_s =~ /\w+/
      create_getter_setter(name)
      @map[name.to_sym]
    else
      super
    end
  end

  def respond_to_missing?(name, *args)
    method =~ /\w+/ || super
  end

  def delete_field(name)
    name = name.to_sym
    return (raise NameError.new("'#{name}' does not exist in #{self}", name)) unless @map.key?(name)

    singleton_class.remove_method(name, "#{name}=")
    @map.delete(name)
  end

  def do_each
    @map.each_pair { |proc| yield proc }
  end

  def each_pair(&block)
    if block
      @map.each_pair { |proc| yield proc }
      self
    else
      to_enum(:do_each)
    end
  end
end
