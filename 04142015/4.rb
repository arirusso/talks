# Construct a MIDI message object using midi-message
# (this example is meant to be entered into a repl)

require "pp"
require "midi-message" # https://github.com/arirusso/midi-message

@message = MIDIMessage::NoteOn.new(0, 64, 100)

pp @message
