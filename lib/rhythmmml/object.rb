require "rhythmmml/z_order"

module Rhythmmml
  module Object
    module Base
      attr_reader :x, :y
      def initialize(window, x, y, options={})
        @window = window
        @x = x
        @y = y
        @color = options[:color] || Gosu::Color::WHITE
        @z_order = options[:z_order] || ZOrder::OBJECT
        @font_name = options[:font_name] || "PressStart2P"
        @font_path = File.join(@window.options[:font_dir],
                               "#{@font_name}.ttf")
        @font_size = options[:font_size] || 24
        @font = Gosu::Font.new(@window,
                               @font_path,
                               @font_size)
      end

      def update
      end

      def draw
      end

      def draw_rectangle(x1, y1, x2, y2, color, z)
        @window.draw_quad(x1, y1, color,
                          x2, y1, color,
                          x2, y2, color,
                          x1, y2, color,
                          z)
      end
    end

    class Rhythm
      include Base

      attr_reader :info
      def initialize(window, x, y, info, options={})
        super(window, x, y, options)
        @info = info
        @width2 = @window.width * 0.1 / 2
        @height2 = @window.height * 0.02 / 2
      end

      def update
        @y += 1
      end

      def draw
        x1 = @x - @width2
        y1 = @y - @height2
        x2 = @x + @width2
        y2 = @y + @height2
        draw_rectangle(x1, y1, x2, y2, @color, @z_order)
      end
    end

    class Info
      include Base

      attr_accessor :score
      def initialize(window, x, y, options={})
        super
        @score = 0
      end

      def draw
        @font.draw("SCORE:", @x, @y, @z_order)
        @font.draw("%08d" % @score, @x, @y + @font_size, @z_order)
      end
    end
  end
end
