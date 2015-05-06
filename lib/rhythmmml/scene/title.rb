require "gosu"
require "rhythmmml/z_order"
require "rhythmmml/scene/base"
require "rhythmmml/scene/main"

module Rhythmmml
  module Scene
    class Title
      include Base

      def initialize(window)
        super
        @title = Gosu::Image.from_text(@window,
                                       "Rhythmmml",
                                       @font_path,
                                       64,
                                       4,
                                       @window.width,
                                       :center)
        @guide = Gosu::Image.from_text(@window,
                                       "press enter",
                                       @font_path,
                                       36,
                                       4,
                                       @window.width,
                                       :center)
        @guide_color = Gosu::Color::WHITE
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
          @window.scenes.unshift(Main.new(@window))
        end
      end
    end
  end
end
