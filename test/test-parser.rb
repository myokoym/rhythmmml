require "rhythmmml/parser"

class TestParser < Test::Unit::TestCase
  def test_a_scale
    parser = Rhythmmml::Parser.new("c", 8000)
    assert_equal([
                   ["c", 0.5, [523.252, 8000, 0.5, 0.5]],
                 ],
                 parser.parse)
  end
end
