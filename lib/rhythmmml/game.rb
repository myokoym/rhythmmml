require "gosu"
require "gosu/swig_patches"
require "gosu/patches"
require "rhythmmml/scene"

module Rhythmmml
  class Game < Gosu::Window
    attr_reader :mml, :options, :scenes
    def initialize(mml, options={})
      super(640, 480, false)
      self.caption = "Rhythmmml"
      @mml = mml
      @options = options
      @options[:font_dir] ||= File.expand_path("../../../data/fonts", __FILE__)
      @scenes = []
      @scenes << Scene::Title.new(self)
    end

    def update
      current_scene.update
    end

    def draw
      current_scene.draw
    end

    def button_down(id)
      case id
      when Gosu::KbEscape
        close
      else
        current_scene.button_down(id)
      end
    end

    private
    def current_scene
      @scenes[0]
    end
  end
end
