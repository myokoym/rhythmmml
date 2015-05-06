module Rhythmmml
  module Scene
    module Base
      def initialize(window)
        @window = window
        @font_path = File.join(@window.options[:font_dir],
                               "PressStart2P.ttf")
        @objects = []
        @figures = []
      end

      def update
        @objects.each {|object| object.update }
      end

      def draw
        @objects.each {|object| object.draw }
        @figures.each {|figure| figure.draw }
      end

      def button_down(id)
      end
    end
  end
end
