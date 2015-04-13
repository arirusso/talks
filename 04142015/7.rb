# This is the most basic example of using Topaz
# On each quarter note, a counter is stepped and displayed

require "topaz" # https://github.com/arirusso/topaz

counter = 0

# Sets quarter note = 132 bpm
@tempo = Topaz::Tempo.new(132) do
  counter += 1
  puts "step #{counter}"
end

puts "Control-C to exit"
puts

@tempo.start
