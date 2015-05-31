# Basic demonstration of the Diamond arpeggiator
# (this example is meant to be entered into a repl)

require "diamond" # https://github.com/arirusso/diamond
require "unimidi" # https://github.com/arirusso/unimidi

# Select a MIDI output
@output = UniMIDI::Output.gets

options = {
  :midi => @output, # Output notes to the MIDI output
  :gate => 90, # How long the notes ring out
  :pattern => "UpDown", # Which arpeggiation algorithm to use
  :interval => 7, # Argument to provide an interval for the arpeggiation algorithm
  :range => 4, # Argument for how many octaves to apply to arpeggiation algorithm for
  :rate => 8, # How to divide the beat
  :tx_channel => 1 # What MIDI channel to publish to
}

# Create a clock with tempo of 101 bpm
@clock = Diamond::Clock.new(101)

# Instantiate the arpeggiator
@arpeggiator = Diamond::Arpeggiator.new(options)

# Make the clock aware of the arpeggiator
@clock << @arpeggiator

# Feed the arpeggiator/pattern algorithm notes
@chord = ["C1", "G1", "Bb2", "A3"]
@arpeggiator.add(*@chord)

# Start the arpeggiator
@clock.start(:background => true)
