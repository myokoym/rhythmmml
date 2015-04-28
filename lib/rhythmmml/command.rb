require "optparse"
require "rhythmmml/version"
require "rhythmmml/game"

module Rhythmmml
  class Command
    def self.run(arguments)
      new(arguments).run
    end

    def initialize(arguments)
      options = parse_options(arguments)
      mml = ARGF.readlines
      @game = Game.new(mml, options)
    end

    def run
      @game.show
    end

    private
    def parse_options(arguments)
      options = {}

      parser = OptionParser.new("#{$0} INPUT_FILE")
      parser.version = VERSION

      parser.on("--sampling_rate=RATE",
                "Specify sampling rate", Integer) do |rate|
        options[:sampling_rate] = rate
      end
      parser.on("--bpm=BPM",
                "Specify BPM (beats per minute)", Integer) do |bpm|
        options[:bpm] = bpm
      end
      parser.on("--octave_reverse",
                "Reverse octave sign (><) effects") do |boolean|
        options[:octave_reverse] = boolean
      end
      parser.on("--channel_delimiter=DELIMITER",
                "Specify channel delimiter") do |delimiter|
        options[:channel_delimiter] = delimiter
      end
      parser.parse!(arguments)

      unless File.pipe?('/dev/stdin') || IO.select([ARGF], nil, nil, 0)
        puts(parser.help)
        exit(true)
      end

      options
    end
  end
end
