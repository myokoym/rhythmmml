require "rhythmmml/z_order"

module Rhythmmml
  module Object
    module Base
      def initialize(window, x, y, options={})
        @window = window
        @x = x
        @y = y
        @color = options[:color] || Gosu::Color::WHITE
        @z_order = options[:z_order] || ZOrder::OBJECT
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

      def initialize(window, x, y, options={})
        super
        @width2 = @window.width * 0.2 / 2
        @height2 = @window.height * 0.1 / 2
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
  end
end
