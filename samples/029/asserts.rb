require 'bundler/setup'

require 'socket'
require 'minitest/autorun'

class AssertSamples < Minitest::Test
  def test_asserts
    # 等しいこと
    assert_equal 5, 2 + 3
    # 空(empty?がtrue)であること
    assert_empty []
    # 要素が含まれること
    assert_includes 1..100, 55
    # 正規表現にマッチすること
    assert_match(/\d{4}-\d{2}-\d{2}/, '2015-02-20')
    # nilであること
    assert_nil @my_undefined
    # あるクラスのインスタンスであること
    assert_instance_of Date, Date.parse('2015-02-20')

    # ブロック内のコードが特定の例外を発生させること
    assert_raises SocketError do
      TCPSocket.new 'no-such-hostname.example.com', 888
    end

    # エラーが起こらないこと
    assert_silent do
      TCPSocket.new 'httpbin.org', 80
    end

    # 標準出力(あるいはエラー出力)にある文字列が出ること
    assert_output "egho\n" do
      puts %w(h o g e).sort.join
    end
  end
end
