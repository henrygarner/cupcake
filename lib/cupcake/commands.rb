module Cupcake
  class Commands
    def version
      send 0.to_byte, 26.to_bytes(2)
    end
    
    def move_to(x, y, z, t)
      send 129.to_byte, x.to_bytes(4), y.to_bytes(4), z.to_bytes(4), t.to_bytes(4)
    end
    
    def send(*args)
      message = Message.new args.join
      message.to_packet
    end
  end
end
