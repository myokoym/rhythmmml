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
                                       "data/fonts/PressStart2P.ttf",
                                       64,
                                       4,
                                       @window.width,
                                       :center)
        @guide = Gosu::Image.from_text(@window,
                                       "press enter",
                                       "data/fonts/PressStart2P.ttf",
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
        rhythms = Parser.new(@window.mml, @window.options).parse
        y = 0
        rhythms.each do |rhythm|
          scale = rhythm[0]
          x_space = @window.width / 8
          case scale
          when /r/i
            y -= rhythm[1] * 60
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
          @objects << Object::Rhythm.new(@window, x, y)
          y -= rhythm[1] * 60
        end

        @info = Object::Info.new(@window, @window.width * 0.7, 0)
        @objects << @info

        bar_y = @window.height * 0.8
        @bar = Figure::Bar.new(@window,
                               0, bar_y,
                               @window.width, bar_y)
        @figures << @bar
        @sampling_rate = @window.options[:sampling_rate] || 8000
        @parser = Mml2wav::Parser.new(@window.mml.delete("r"), @sampling_rate, @window.options)
        @format = WaveFile::Format.new(:mono, :pcm_8, @sampling_rate)
        @buffer_format = WaveFile::Format.new(:mono, :float, @sampling_rate)
      end

      def update
        super
      end

      def draw
        super
      end

      def button_down(id)
        case id
        when Gosu::KbQ
          @window.scenes.shift
        when Gosu::KbJ
          Tempfile.open(["rhythmmml", ".wav"]) do |tempfile|
            WaveFile::Writer.new(tempfile, @format) do |writer|
              samples = @parser.wave!
              unless samples
                @parser = Mml2wav::Parser.new(@window.mml.delete("r"), @sampling_rate, @window.options)
                samples = @parser.wave!
              end
              buffer = WaveFile::Buffer.new(samples, @buffer_format)
              writer.write(buffer)
            end
            Gosu::Sample.new(@window, tempfile.path).play
          end
        end
      end
    end
  end
end
