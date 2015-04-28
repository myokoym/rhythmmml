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
    end

    class Title
      include Base

      def update
      end

      def draw
      end
    end
  end
end
