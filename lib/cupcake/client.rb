require 'serialport'
require 'digest/crc8_1wire'

class Cupcake
  class Client
    attr_reader :port, :connection
    
    def initialize(options = {})
      @port = options[:port]
      establish_connection
    end
    
    def establish_connection
      @connection = SerialPort.new(port, 38400, 8, 1, SerialPort::NONE)
    end
    
    def call(*args)
      payload = args.flatten.pack('C*')
      connection.write "\xd5" + # The start byte
        payload.size.chr +
        payload +
        Digest::CRC81Wire.checksum(payload).chr
      
      connection.getc.unpack('C')
      length = connection.getc.unpack('C').join.to_i
      payload = ""
      length.times do
        payload << connection.getc
      end
      crc = connection.getc.unpack('C').join.to_i
      if Digest::CRC81Wire.checksum(payload) == crc
        payload
      else
        false
      end
    end
    
  end
end