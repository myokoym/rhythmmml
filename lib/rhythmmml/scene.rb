require "gosu"
require "mml2wav"
require "wavefile"
require "tempfile"
require "rhythmmml/object"
require "rhythmmml/figure"
require "rhythmmml/parser"
require "rhythmmml/z_order"

module Rhythmmml
  module Scene
    module Base
      def initialize(window)
        @window = window
        @font_path = File.join(@window.options[:font_dir],
                               "PressStart2P.ttf")
        @objects = []
        @figures = []
      end

      def update
        @objects.each {|object| object.update }
      end

      def draw
        @objects.each {|object| object.draw }
        @figures.each {|figure| figure.draw }
      end

      def button_down(id)
      end
    end

    class Title
      include Base

      def initialize(window)
        super
        @title = Gosu::Image.from_text(@window,
                                       "Rhythmmml",
                                       @font_path,
                                       64,
                                       4,
                                       @window.width,
                                       :center)
        @guide = Gosu::Image.from_text(@window,
                                       "press enter",
                                       @font_path,
                                       36,
                                       4,
                                       @window.width,
                                       :center)
        @guide_color = Gosu::Color::WHITE
      end

      def update
        super
        if Time.now.sec % 2 == 0
          @guide_color = Gosu::Color::WHITE
        else
          @guide_color = Gosu::Color::GRAY
        end
      end

      def draw
        super
        @title.draw(0, @window.height * 0.2, ZOrder::TEXT)
        @guide.draw(0, @window.height * 0.6, ZOrder::TEXT,
                    1, 1, @guide_color)
      end

      def button_down(id)
        case id
        when Gosu::KbReturn
          @window.scenes.unshift(Main.new(@window))
        end
      end
    end

    class Main
      include Base

      def initialize(window)
        super
        @rhythms = []
        @sampling_rate = @window.options[:sampling_rate] || 22050
        rhythm_infos = Parser.new(@window.mml, @sampling_rate, @window.options).parse
        y = 0
        rhythm_infos.each do |rhythm_info|
          scale = rhythm_info[0]
          x_space = @window.width / 8
          case scale
          when /r/i
            y -= rhythm_info[1] * 60
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
          y -= rhythm_info[1] * 60
        end

        @info = Object::Info.new(@window, @window.width * 0.7, 0)
        @objects << @info

        @bar_y = @window.height * 0.8
        @bar = Figure::Bar.new(@window,
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
              Tempfile.open(["rhythmmml", ".wav"]) do |tempfile|
                WaveFile::Writer.new(tempfile, @format) do |writer|
                  samples = sine_wave(*rhythm.info[2])
                  buffer = WaveFile::Buffer.new(samples, @buffer_format)
                  writer.write(buffer)
                end
                Gosu::Sample.new(@window, tempfile.path).play
              end
              @objects.delete(rhythm)
              @rhythms.delete(rhythm)
              break
            end
          end
        end
      end

      private
      def sine_wave(frequency, sampling_rate, sec, amplitude=0.5)
        max = sampling_rate * sec
        if frequency == 0
          return Array.new(max) { 0.0 }
        end
        base_x = 2.0 * Math::PI * frequency / sampling_rate
        1.upto(max).collect do |n|
          amplitude * Math.sin(base_x * n)
        end
      end
    end
  end
end
