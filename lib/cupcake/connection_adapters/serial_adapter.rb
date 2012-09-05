module Cupcake
  module ConnectionAdapters
    class SerialAdapter
      
      def establish_connection
        @connection = SerialPort.new port, 38400, 8, 1, SerialPort::None
      end
      
      def send(message)
        io.write "\xd5" + # The start byte
          message.size.chr +
          message +
          Digest::CRC81Wire.checksum(message).chr
      end
      
      def receive
        
      end
    end
  end
end
