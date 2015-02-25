RUBY_VERSION #=> "2.1.2"
def foo; 123 end
def bar(foo = foo)
  p foo       # => 123
  p foo.class # => Fixnum
end

# Ruby2.2からは警告を出した上で、nilが代入されるようになる
RUBY_VERSION #=> "2.2.0"
def foo; 123 end
def bar(foo = foo)
  p foo       # => nil
  p foo.class # => NilClass
end
# => warning: circular argument reference - foo
