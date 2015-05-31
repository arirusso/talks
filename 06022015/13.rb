# Basic demo of patch controlling a web page via MIDI and OSC
#
# Start webserver with :
#   `cd patch/examples/simple`
#   `rackup config.ru`
#

require "patch" # https://github.com/arirusso/patch
require "unimidi" # https://github.com/arirusso/unimidi

@websocket = Patch::IO::Websocket::Node.new(1, "localhost", 9006)
@midi = Patch::IO::MIDI::Input.new(2, UniMIDI::Input.gets)
@osc = Patch::IO::OSC::Server.new(3, 8000, :echo => { :host => "192.168.1.118", :port => 9000})

@map = { [@midi, @osc] => @websocket }

@action = {
  :name => "Text Size",
  :key => "zoom",
  :default => {
    :scale => 10..200
  },
  :midi => {
    :channel => 0,
    :index => 0
  },
  :osc => {
    :address=>"/1/rotaryA",
    :scale => 0..1.0
  }
}

@patch = Patch::Patch.new(:simple, @map, @action)

@hub = Patch::Hub.new(:patch => @patch)
Patch::Report.print(@hub)
@hub.listen
