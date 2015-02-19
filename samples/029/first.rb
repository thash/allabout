require 'bundler/setup'
require 'minitest/autorun'

class MyClass
  def add(x, y)
    x + y
  end
end

# Minitest::Testを継承
class TestMyClass < Minitest::Test
  def setup
    @my = MyClass.new
  end

  # test_* にマッチするメソッドを定義
  def test_add
    assert_equal 5, @my.add(2, 3)
  end
end
