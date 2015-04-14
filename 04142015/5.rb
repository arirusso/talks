# Parse some raw MIDI data using nibbler
# (this example is meant to be entered into a repl)

require "nibbler" # https://github.com/arirusso/nibbler

nibbler = Nibbler.new

nibbler.parse("90")
nibbler.parse("40")
nibbler.parse("40")
nibbler.parse("904040")
nibbler.parse(0x90, 64, 100)

# Alternatively use the Midilib MIDI message library
midilib_nibbler = Nibbler.new(:message_lib => :midilib)

midilib_nibbler.parse("9", "0", 64, 64)
