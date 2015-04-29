module Rhythmmml
  module Figure
    module Base
      def initialize(window, color=nil)
        @window = window
        @color = color || Gosu::Color::WHITE
      end
    end

    class Bar
      include Base

      def initialize(window, x1, y1, x2, y2, color=nil)
        super(window, color)
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
      end

      def draw
        @window.draw_line(@x1, @y1, @color,
                          @x2, @y2, @color)
      end
    end
  end
end
