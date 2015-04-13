# Do some low-level MIDI output using unimidi

require "unimidi" # https://github.com/arirusso/unimidi

@notes = [36, 39, 43, 46, 48, 51, 55, 58, 60, 63, 67, 70] # C Eb G Bb
duration = 0.25

@output = UniMIDI::Output.gets

3.times do |i|

  (i % 2 == 0 ? @notes : @notes.reverse).each do |note|
    @output.puts(0x90, note, 100)
    sleep(duration)
    @output.puts(0x80, note, 100)
  end

end
