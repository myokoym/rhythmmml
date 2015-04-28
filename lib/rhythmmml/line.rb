module Rhythmmml
  class Line
    def initialize(window, x1, y1, x2, y2, color)
      @window = window
      @x1 = x1
      @y1 = y1
      @x2 = x2
      @y2 = y2
      @color = color
    end

    def draw
      @window.draw_line(@x1, @y1, @color,
                        @x2, @y2, @color)
    end
  end
end
