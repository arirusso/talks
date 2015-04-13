# Basic demonstration of the Diamond arpeggiator
# (this example is meant to be entered into a repl)

require "diamond" # https://github.com/arirusso/diamond
require "unimidi" # https://github.com/arirusso/unimidi

@output = UniMIDI::Output.gets

options = {
  :gate => 90,
  :interval => 7,
  :midi => @output,
  :pattern => "UpDown",
  :range => 4,
  :rate => 8,
  :tx_channel => 1
}

@clock = Diamond::Clock.new(101)

@arpeggiator = Diamond::Arpeggiator.new(options)

@clock << @arpeggiator

@chord = ["C1", "G1", "Bb2", "A3"]

@arpeggiator.add(*@chord)

@clock.start
