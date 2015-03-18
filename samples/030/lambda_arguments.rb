RUBY_VERSION #=> 2.1.2
lam = ->(word, index) { word.length == 3 }
#=> #<Proc:0x007fe112b26ba0@(pry):27 (lambda)>
%w(Hi there how are you).each_with_index.detect &lam
#=> ArgumentError: wrong number of arguments (1 for 2)

RUBY_VERSION #=> 2.2.0
lam = ->(word, index) { word.length == 3 }
#=> #<Proc:0x007f856e44cb90@(pry):70 (lambda)>
%w(Hi there how are you).each_with_index.detect &lam
#=> ["how", 2]
