require "gosu"
require "rhythmmml/object"
require "rhythmmml/figure"
require "rhythmmml/z_order"

module Rhythmmml
  module Scene
    module Base
      def initialize(window)
        @window = window
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

    class Title
      include Base

      def initialize(window)
        super
        @title = Gosu::Image.from_text(@window,
                                       "Rhythmmml",
                                       "data/fonts/PressStart2P.ttf",
                                       64,
                                       4,
                                       @window.width,
                                       :center)
        @guide = Gosu::Image.from_text(@window,
                                       "press enter",
                                       "data/fonts/PressStart2P.ttf",
                                       36,
                                       4,
                                       @window.width,
                                       :center)
        @guide_color = Gosu::Color::WHITE
        @main = Main.new(@window)
      end

      def update
        super
        if Time.now.sec % 2 == 0
          @guide_color = Gosu::Color::WHITE
        else
          @guide_color = Gosu::Color::GRAY
        end
      end

      def draw
        super
        @title.draw(0, @window.height * 0.2, ZOrder::TEXT)
        @guide.draw(0, @window.height * 0.6, ZOrder::TEXT,
                    1, 1, @guide_color)
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
        @rhythm = Object::Rhythm.new(@window, @window.width / 2, 0)
        @objects << @rhythm

        @info = Object::Info.new(@window, @window.width * 0.7, 0)
        @objects << @info

        bar_y = @window.height * 0.8
        @bar = Figure::Bar.new(@window,
                               0, bar_y,
                               @window.width, bar_y)
        @figures << @bar
      end

      def update
        super
      end

      def draw
        super
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
