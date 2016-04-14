require "gosu"
require "mml2wav"
require "wavefile"
require "tmpdir"
require "rhythmmml/object"
require "rhythmmml/z_order"
require "rhythmmml/scene/base"

module Rhythmmml
  module Scene
    class Main
      include Base

      def initialize(window)
        super
        @rhythms = []
        @sampling_rate = @window.options[:sampling_rate] || 22050
        rhythm_infos = Mml2wav::Parser.new(@window.mml, @sampling_rate, @window.options).parse
        y = 0
        rhythm_infos.each do |rhythm_info|
          scale = rhythm_info[:sound]
          x_space = @window.width / 8
          case scale
          when /r/i
            y -= rhythm_info[:sec] * 60
            next
          when /c/i
            x = x_space * 1
          when /d/i
            x = x_space * 2
          when /e/i
            x = x_space * 3
          when /f/i
            x = x_space * 4
          when /g/i
            x = x_space * 5
          when /a/i
            x = x_space * 6
          when /b/i
            x = x_space * 7
          end
          rhythm = Object::Rhythm.new(@window, x, y, rhythm_info)
          @rhythms << rhythm
          @objects << rhythm
          y -= rhythm_info[:sec] * 60
        end

        @info = Object::Info.new(@window, @window.width * 0.7, 0)
        @objects << @info

        @bar_y = @window.height * 0.8
        @bar = Object::Bar.new(@window,
                               0, @bar_y,
                               @window.width, @bar_y)
        @figures << @bar
        @format = WaveFile::Format.new(:mono, :pcm_8, @sampling_rate)
        @buffer_format = WaveFile::Format.new(:mono, :float, @sampling_rate)

        @guide = Gosu::Image.from_text(@window,
                                       "press space key",
                                       @font_path,
                                       20,
                                       4,
                                       @window.width,
                                       :center)
      end

      def update
        super
      end

      def draw
        super
        @guide.draw(0, @window.height * 0.9, ZOrder::TEXT)
      end

      def button_down(id)
        case id
        when Gosu::KbQ
          @window.scenes.shift
        when Gosu::KbSpace
          @rhythms.each do |rhythm|
            distance = (@bar_y - rhythm.y).abs
            if distance < 10
              @info.score += 10 - distance
              Dir.mktmpdir("rhythmmml") do |dir|
                path = File.join(dir, "a.wav")
                WaveFile::Writer.new(path, @format) do |writer|
                  info = rhythm.info
                  samples = Mml2wav::Wave.sine_wave(info[:frequency],
                                                    info[:sampling_rate],
                                                    info[:sec],
                                                    info[:amplitude])
                  buffer = WaveFile::Buffer.new(samples, @buffer_format)
                  writer.write(buffer)
                end
                Gosu::Sample.new(@window, path).play
              end
              @objects.delete(rhythm)
              @rhythms.delete(rhythm)
              break
            end
          end
        end
      end
    end
  end
end
