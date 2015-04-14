# Live coding using micromidi
# (this example is meant to be entered into a repl)

require "midi" # https://github.com/arirusso/micromidi

@input = MIDI::Input.gets
@output = MIDI::Output.gets

@midi = MIDI::Session.new(@input, @output)

# Use sticky presets
@midi.channel 0
@midi.velocity 100
@midi.octave 4

# Send messages
@midi.cc 1, 0
@midi.play "D", 0.3
@midi.play "F", 0.3
@midi.play "A", 0.3
@midi.play "B", 0.3
@midi.play "F", 0.6

# Control change
@midi.cc 1, 127
@midi.play "E", 0.6
@midi.play "G#", 0.6

@midi.cc 1, 0

# Add control change (mod wheel) scaled to the note value
@midi.receive(:note_on) do |message|
  @midi.cc 1, message.note
  @midi.output(message)
end
