require "mml2wav"

module Rhythmmml
  class Parser
    def initialize(mml, options={})
      pattern = /T\d+|L\d+|[A-GR][#+-]?\d*\.?/i
      @sounds = mml.scan(pattern)
      @bpm = options[:bpm] || 120
      @default_length = options[:default_length] || 4.0
    end

    def parse
      rhythms = []
      @cursor = 0
      @cursor.upto(@sounds.size - 1) do |i|
        sound = @sounds[i]
        base_sec = 60.0 * 4
        length = @default_length
        case sound
        when /\AT(\d+)/i
          @bpm = $1.to_i
          next
        when /\AL(\d+)/i
          @default_length = $1.to_f
          next
        when /\A([A-GR][#+-]?)(\d+)(\.)?/i
          length = $2.to_f
          sound = $1
          length = @default_length / 1.5 if $3
        end
        sec = base_sec / length / @bpm
        frequency = Mml2wav::Scale::FREQUENCIES[sound.downcase]
        next unless frequency
        rhythms << [sound.downcase, sec]
        @cursor = i + 1
      end
      rhythms
    end
  end
end
