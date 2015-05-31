# Display raw MIDI input using unimidi

require "pp"
require "unimidi" # https://github.com/arirusso/unimidi

@input = UniMIDI::Input.gets

10.times do
  pp @input.gets
end
