require "rhythmmml"

class TestScene < Test::Unit::TestCase
  def setup
    mml = "cde"
    options = {
      width: 1,
      height: 1,
    }
    @window = Rhythmmml::Game.new(mml, options)
  end

  class TitleTest < self
    def test_new
      assert_not_nil(Rhythmmml::Scene::Title.new(@window))
    end
  end

  class MainTest < self
    def test_main
      assert_not_nil(Rhythmmml::Scene::Title.new(@window))
    end
  end
end
