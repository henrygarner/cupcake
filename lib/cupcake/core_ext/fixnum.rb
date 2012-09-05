class Fixnum
  def to_byte
    to_bytes(1)
  end
  def to_bytes(size)
    bytearray(size).pack('C*')
  end
  def bytearray(size)
    # Least significant bytes first
    Array.new(size) { |index| ((self >> index * 8) & 0xff) }
  end
end
