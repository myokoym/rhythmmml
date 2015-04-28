require "gosu"
require "rhythmmml/line"

module Rhythmmml
  module Scene
    module Base
      def initialize(window)
        @window = window
        @font = Gosu::Font.new(@window, "data/fonts/PressStart2P.ttf", 24)
      end

      def update
      end

      def draw
      end

      def button_down(id)
      end
    end

    class Title
      include Base

      def initialize(window)
        super
        @main = Main.new(@window)
      end

      def update
      end

      def draw
        @font.draw("Title", 0, 0, 3)
      end

      def button_down(id)
        case id
        when Gosu::KbReturn
          @window.scenes.unshift(@main)
        end
      end
    end

    class Main
      include Base

      def initialize(window)
        super
        bar_y = @window.height * 0.8
        @bar = Line.new(@window,
                        0, bar_y,
                        @window.width, bar_y,
                        Gosu::Color::WHITE)
      end

      def draw
        @bar.draw
        @font.draw("Main", 0, 0, 3)
      end

      def button_down(id)
        case id
        when Gosu::KbQ
          @window.scenes.shift
        end
      end
    end
  end
end
