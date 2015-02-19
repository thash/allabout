require 'bundler/setup'
require 'minitest/autorun'

class MySpec
  def mul(x, y)
    x * y
  end
end

describe MySpec do
  before do
    @my = MySpec.new
  end

  it { @my.mul(2, 3).must_equal 6 }

  it '説明テキスト' do
    @my.mul(2, 10).must_equal 20
  end

  # 実はassertで書いても大丈夫
  it { assert_equal 6, @my.mul(2, 3) }
end
