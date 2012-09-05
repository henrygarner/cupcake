require 'serialport'
require 'digest/crc8_1wire'

module Cupcake
  class Connection
    attr_reader :io
    
    def establish(port)
      @io = SerialPort.new port, 38400, 8, 1, SerialPort::None
    end
    
    def send(message)
      io.write "\xd5" + # The start byte
      message.size.chr +
      message +
      Digest::CRC81Wire.checksum(message).chr
    end
    
    def receive
      completed = false
      until completed
        
      end
    end
    
    def read
      io.getc
    end
    
  end
end
