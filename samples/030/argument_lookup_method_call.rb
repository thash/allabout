RUBY_VERSION #=> "2.2.0"
def foo; 123 end
# 以前と同じ挙動をさせたい場合はメソッド呼び出しであることを明確にするため()を付ける
def bar(foo = foo())
  p foo       # => 123
  p foo.class # => Fixnum
end
