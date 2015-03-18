# メソッド引数以外では以前からこの動作
RUBY_VERSION #=> "2.1.2"
x = x #=> nil
x     #=> nil

RUBY_VERSION #=> "2.2.0"
x = x #=> nil
x     #=> nil
