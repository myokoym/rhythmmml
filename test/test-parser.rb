require "rhythmmml/parser"

class TestParser < Test::Unit::TestCase
  def test_a_scale
    parser = Rhythmmml::Parser.new("c", 8000)
    assert_equal([
                   ["c", 0.5, [523.252, 8000, 0.5, 0.5]],
                 ],
                 parser.parse)
  end

  def test_length
    parser = Rhythmmml::Parser.new("c8", 8000)
    assert_equal([
                   ["c", 0.25, [523.252, 8000, 0.25, 0.5]],
                 ],
                 parser.parse)
  end

  def test_dot
    parser = Rhythmmml::Parser.new("c.", 8000)
    assert_equal([
                   ["c", 0.75, [523.252, 8000, 0.75, 0.5]],
                 ],
                 parser.parse)
  end

  def test_length_with_dot
    parser = Rhythmmml::Parser.new("c8.", 8000)
    assert_equal([
                   ["c", 0.375, [523.252, 8000, 0.375, 0.5]],
                 ],
                 parser.parse)
  end
end
