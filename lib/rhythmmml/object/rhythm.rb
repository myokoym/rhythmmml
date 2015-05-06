require "rhythmmml/z_order"

module Rhythmmml
  module Object
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
  end
end
