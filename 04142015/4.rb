# Construct a MIDI message object using midi-message
# (this example is meant to be entered into a repl)

require "pp"
require "midi-message" # https://github.com/arirusso/midi-message
require "unimidi" # https://github.com/arirusso/unimidi

@output = UniMIDI::Output.gets

@message = MIDIMessage::NoteOn.new(0x0, 64, 100)

pp @message

@output.puts(@message.to_a)

@output.puts(@message.to_note_off.to_a)
