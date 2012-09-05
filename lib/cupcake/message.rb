require 'digest/crc8_1wire'

module Cupcake
  class Message
    attr_reader :payload
    
    def initialize(payload = "")
      @payload = payload
    end
    
    def append(buffer)
      @payload += buffer
    end
    
    def to_packet
      "\xd5" + # The start byte
      payload.size.chr +
      payload +
      Digest::CRC81Wire.checksum(payload).chr
    end
  end
end
