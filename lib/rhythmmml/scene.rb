require "gosu"

module Rhythmmml
  module Scene
    module Base
      def initialize(window)
        @window = window
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

      def draw
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
