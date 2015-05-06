module Rhythmmml
  module Object
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
