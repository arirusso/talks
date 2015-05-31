# This example mutates received MIDI messages and sends them to an output

require "midi-eye" # https://github.com/arirusso/midi-eye

# Initialize MIDI IO
@input = UniMIDI::Input.gets
@output = UniMIDI::Output.gets

# Create a listener for the input port
@transpose = MIDIEye::Listener.new(@input)

# Have to cache the mutated notes in order to properly send note-offs
new_notes = {}

# Bind an event to the listener
@transpose.on_message(:class => [MIDIMessage::NoteOn, MIDIMessage::NoteOff]) do |event|

  # Raise the note value by an octave
  new_note = new_notes[event[:message].note] ||= event[:message].note + rand(5)
  puts "Transposing from note #{event[:message].note} to note #{(new_note)}"
  event[:message].note = new_note

  # Send the altered note message to the output
  @output.puts(event[:message])

end

# Start the listener
p "Control-C to quit..."
@transpose.run
