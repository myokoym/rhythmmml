require "gosu"
require "rhythmmml/scene"

module Rhythmmml
  class Game < Gosu::Window
    attr_reader :mml, :options
    def initialize(mml, options={})
      super(640, 480, false)
      @mml = mml
      @options = options
      @scenes = []
      @scenes << Scene::Title.new(self)
    end

    def update
      @scenes[0].update
    end

    def draw
      @scenes[0].draw
    end

    def button_down(id)
      case id
      when Gosu::KbEscape
        close
      end
    end
  end
end
