b = lambda {|i| i*i }
[1,2,3].map(&b) # => [1, 4, 9]

[5] pry(main)> [1,2,3].map(b.to_proc)
ArgumentError: wrong number of arguments (1 for 0)
from (pry):5:in `map'
[6] pry(main)> [1,2,3].map(:b.to_proc)
ArgumentError: wrong number of arguments (1 for 0)
from (pry):6:in `map'
