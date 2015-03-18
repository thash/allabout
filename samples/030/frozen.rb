RUBY_VERSION # => 2.1.2
[true, false, nil].map(&:frozen?)
=> [false, false, false]

RUBY_VERSION # => 2.2.0
[true, false, nil].map(&:frozen?)
=> [true, true, true]
