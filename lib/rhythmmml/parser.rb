require "mml2wav"

module Rhythmmml
  class Parser
    def initialize(sounds, sampling_rate, options={})
      pattern = /T\d+|V\d+|L\d+|[A-GR][#+-]?\d*\.?|O\d+|[><]|./i
      @sounds = sounds.scan(pattern)
      @sampling_rate = sampling_rate
      @bpm = options[:bpm] || 120
      @velocity = options[:velocity] || 5
      @octave = options[:octave] || 4
      @default_length = options[:default_length] || 4.0
      @octave_reverse = options[:octave_reverse] || false
      @cursor = 0
    end

    def parse
      rhythm_infos = []
      @cursor.upto(@sounds.size - 1) do |i|
        sound = @sounds[i]
        base_sec = 60.0 * 4
        length = @default_length
        case sound
        when /\AT(\d+)/i
          @bpm = $1.to_i
          next
        when /\AV(\d+)/i
          @velocity = $1.to_i
          next
        when /\AL(\d+)/i
          @default_length = $1.to_f
          next
        when /\A([A-GR][#+-]?)(\d+)(\.)?/i
          length = $2.to_f
          sound = $1
          length = @default_length / 1.5 if $3
        when /\AO(\d+)/i
          @octave = $1.to_i
          next
        when "<"
          @octave += @octave_reverse ? -1 : 1
          next
        when ">"
          @octave -= @octave_reverse ? -1 : 1
          next
        end
        sec = base_sec / length / @bpm
        amplitude = @velocity.to_f / 10
        frequency = Mml2wav::Scale::FREQUENCIES[sound.downcase]
        next unless frequency
        frequency *= (2 ** @octave)
        rhythm_infos << [sound.downcase, sec, [frequency, @sampling_rate, sec, amplitude]]
        @cursor = i + 1
      end
      rhythm_infos
    end
  end
end
