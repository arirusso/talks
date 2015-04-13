# Using micromidi,
#   print received MIDI messages to the screen
#   send messages thru to output to synthesizer

require "midi" # https://github.com/arirusso/micromidi
require "pp"

@input = MIDI::Input.gets
@output = MIDI::Output.gets

MIDI.using(@input, @output) do

  receive do |message|
    pp(message)
    puts
    output(message)
  end

  loop { wait_for_input }

end
