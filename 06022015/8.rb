# This is similar to #7, but synchronizes to an external MIDI input
# On each quarter note, a counter is stepped and displayed

require "topaz" # https://github.com/arirusso/topaz
require "unimidi" # https://github.com/arirusso/unimidi

# Initialize the input
@input = UniMIDI::Input.gets

counter = 0

@tempo = Topaz::Tempo.new(@input, :midi_transport => true) do
  counter += 1
  puts "step #{counter}"
end

puts "Control-C to exit"
puts

@tempo.start
