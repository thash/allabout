require 'bundler/setup'
require 'minitest/autorun'

class RefuteSamples < Minitest::Test
  def test_refutes
    refute_equal 6, 2 + 3
    refute_empty [1, 2, 3]
    refute_includes 1..100, 550
    refute_match(/\d{4}-\d{2}-\d{2}/, '2015-2-20')
    refute_nil 123
    refute_instance_of Time, Date.parse('2015-02-20')
  end
end
