require "rhythmmml/z_order"

module Rhythmmml
  module Object
    module Base
      attr_reader :x, :y
      def initialize(window, x, y, options={})
        @window = window
        @x = x
        @y = y
        @color = options[:color] || Gosu::Color::WHITE
        @z_order = options[:z_order] || ZOrder::OBJECT
        @font_name = options[:font_name] || "PressStart2P"
        @font_path = File.join(@window.options[:font_dir],
                               "#{@font_name}.ttf")
        @font_size = options[:font_size] || 24
        @font = Gosu::Font.new(@window,
                               @font_path,
                               @font_size)
      end

      def update
      end

      def draw
      end

      def draw_rectangle(x1, y1, x2, y2, color, z)
        @window.draw_quad(x1, y1, color,
                          x2, y1, color,
                          x2, y2, color,
                          x1, y2, color,
                          z)
      end
    end
  end
end
