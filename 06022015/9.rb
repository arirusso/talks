# Synchronizes to an external MIDI input,
# On each quarter note, plays a note (similar to example #2)

require "topaz" # https://github.com/arirusso/topaz
require "unimidi" # https://github.com/arirusso/unimidi

# Initialize the IO
@input = UniMIDI::Input.gets
@output = UniMIDI::Output.gets

@notes = [36, 39, 43, 46, 48, 51, 55, 58, 60, 63, 67, 70] # C Eb G Bb
duration = 0.22
counter = 0

# Create a tempo, synched to the input
@tempo = Topaz::Tempo.new(@input, :midi_transport => true) do
  # Select the current note
  note = @notes[counter] || @notes[counter = 0]
  p "Playing note #{note} (index #{counter})"
  # Output the note
  @output.puts(0x90, note, 100)
  sleep(duration)
  # Note off
  @output.puts(0x80, note, 100)
  counter += 1
end

puts "Control-C to exit"
puts

@tempo.start
