require "rhythmmml/object/base"

module Rhythmmml
  module Object
    class Bar
      include Base

      def initialize(window, x1, y1, x2, y2, options={})
        super(window, x1, y1, options)
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
      end

      def draw
        @window.draw_line(@x1, @y1, @color,
                          @x2, @y2, @color,
                          @z_order)
      end
    end
  end
end
