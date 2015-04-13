# Sync multiple Arpeggiators to each other
# this is meant to be used in the repl

require "diamond" # https://github.com/arirusso/diamond
require "unimidi" # https://github.com/arirusso/unimidi

@input = UniMIDI::Input.gets
@output = UniMIDI::Output.gets

def fibonacci(n)
  n = fibonacci( n - 1 ) + fibonacci( n - 2 ) if n > 1
  n
end

Diamond::Pattern.add("fibonacci") { |range, interval| 0.upto(range).map { |n| fibonacci(n) } }

# Basic options
options = {
  :gate => 90,
  :interval => 7,
  :midi => @output,
  :pattern => "UpDown",
  :range => 2,
  :rate => 8
}

@arpeggiators = 2.times.map do |i|
  arpeggiator = Diamond::Arpeggiator.new(options)
  arpeggiator.tx_channel = i
  arpeggiator.transpose(i * 12)
  arpeggiator.range += i
  arpeggiator.rate = 4 * (2 ** i)
  arpeggiator.pattern = Diamond::Pattern.find("fibonacci")
  arpeggiator
end

# A clock to control all of the arpeggiators
@clock = Diamond::Clock.new(@input, :midi => @output)

@clock << @arpeggiators

# Some notes..
@chord = ["C0", "G0", "Bb0", "A2"]

@arpeggiators.each { |arpeggiator| arpeggiator << @chord }

# Start the clock
@clock.start(:background => true)
