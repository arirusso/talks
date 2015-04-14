# Sync multiple Arpeggiators to each other
# (this is meant to be used in the repl)

require "diamond" # https://github.com/arirusso/diamond
require "unimidi" # https://github.com/arirusso/unimidi

# Select MIDI IO
@input = UniMIDI::Input.gets
@output = UniMIDI::Output.gets

# Add a custom arpeggiation pattern based on Fibonacci function
def fibonacci(n)
  n = fibonacci( n - 1 ) + fibonacci( n - 2 ) if n > 1
  n
end

Diamond::Pattern.add("fibonacci") { |range, interval| 0.upto(range).map { |n| fibonacci(n) } }

# Basic options
options = {
  :midi => @output, # Use the MIDI output
  :gate => 90, # How long the notes ring out for
  :pattern => Diamond::Pattern.find("fibonacci"), # Use the Fibonacci pattern
  :range => 2, # The range argument for the Fibonacci arpeggiation function (how many octaves)
  :interval => 7, # The interval argument for the Fibonacci arpeggiation function
    # (The interval is ignored by the fibonacci algorithm, but if we switched patterns we would want
    # that argument available)
}

# Instantiate some arpeggiators
@arpeggiators = 3.times.map do |i|
  arpeggiator = Diamond::Arpeggiator.new(options)
  # Mutate the options for each one
  arpeggiator.tx_channel = i
  arpeggiator.transpose(i * 12)
  arpeggiator.range += i
  arpeggiator.rate = 4 * (2 ** i)
  arpeggiator
end

# A clock to control all of the arpeggiators
@clock = Diamond::Clock.new(@input, :midi => @output)

# Make the clock aware of the arpeggiators
@clock << @arpeggiators

# Give the arpeggiators some notes
@chord = ["C0", "G0", "Bb0", "A2"]
@arpeggiators.each { |arpeggiator| arpeggiator << @chord }

# Start the clock
@clock.start(:background => true)
