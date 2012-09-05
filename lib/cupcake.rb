require "cupcake/version"
require "cupcake/client"
require "cupcake/core_ext"

class Cupcake
  attr_reader :client
  
  def initialize(options = {})
    @client = Client.new options
    @position = 0
  end
  
  def version
    # request version, our version (2 bytes)
    client.call [0, 26, 0]
  end
  
  def build_name
    # build name, our version (2 bytes)
    client.call [20, 26, 0]
  end
  
  def temperature
    # tool query, tool index, tool command
    client.call [10, 0, 2]
  end
  
  def set_temperature(t)
    payload_length = 2
    # tool command, which tool, which command, length, temerature
    client.call [136, 0, 3, payload_length, t.bytearray(payload_length)]
  end
  
  def start_extruder
    # tool command, which tool, which command, length, flags
    client.call [136, 0, 10, 1, 3]
  end
  
  def stop_extruder
    # tool command, which tool, which command, length, flags
    client.call [136, 0, 10, 1, 2]
  end
  
  def move_to(x, y, z, t)
    # queue point absolute, x, y, z, t
    
    # Assumes z movement is small!!
    
    client.call 129, x.bytearray(4), y.bytearray(4), z.bytearray(4), t.bytearray(4)
  end
  
  def position
    # Get Position (what's get position ext?)
    response = client.call 4
    response[1...-1].unpack('L*')
  end
  
  def toolhead_msecs(x, y)
    h = Math.sqrt x**2 + y**2
    (h * 60_000_000) / (12 * 5000)
  end
  
  def home
    client.call 130, 0.bytearray(4), 0.bytearray(4), 0.bytearray(4)
  end
  
  def reset_position!
    @position = position
  end
  
end
