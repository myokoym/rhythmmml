require "rhythmmml/z_order"

module Rhythmmml
  module Figure
    module Base
      def initialize(window, options={})
        @window = window
        @color = options[:color] || Gosu::Color::WHITE
        @z_order = options[:z_order] || ZOrder::FIGURE
      end
    end

    class Bar
      include Base

      def initialize(window, x1, y1, x2, y2, options={})
        super(window, options)
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
