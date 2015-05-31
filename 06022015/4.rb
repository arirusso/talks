# Construct a MIDI message object using midi-message
# (this example is meant to be entered into a repl)

require "pp"
require "midi-message" # https://github.com/arirusso/midi-message
require "unimidi" # https://github.com/arirusso/unimidi

# Select an output
@output = UniMIDI::Output.gets

# Create a note on message
@message = MIDIMessage::NoteOn.new(0x0, 64, 100)

# Output the note on message
@output.puts(*@message.to_a)

# Create a note off from the note on
@off = @message.to_note_off

# Output the note off
@output.puts(*@off.to_a)
