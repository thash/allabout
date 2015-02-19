require 'bundler/setup'
require 'minitest/autorun'

def fibonacci(n)
end

class TestFibonacci < Minitest::Test
  def test_fibonacci
    assert_equal 0, fibonacci(0)
  end
end
