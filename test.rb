require 'rubygems'
require 'redis'
$: << File.dirname(__FILE__) + '/lib'
require './lib/cupcake'

cupcake = Cupcake.new :port => '/dev/tty.usbserial-FTESJEY4'
redis = Redis.new
cupcake.set_temperature 260
cupcake.start_extruder

loop do
  coords = redis.get 'coords'
  puts coords
  if coords
    x, y = coords.split ','
    x = ((x.to_f / 14720) * -1200) - 600
    y = ((y.to_f / 9200) * 1200) - 600
    cupcake.move_to x.to_i, y.to_i, 0, 1500
    sleep 0.1
  end
end

