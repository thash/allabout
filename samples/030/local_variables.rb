a = 1
b = 2

RUBY_VERSION # => 2.1.2
local_variables # => [:a, :b]
binding.eval('local_variables') # => [:a, :b]
binding.local_variables
# => NoMethodError: private method `local_variables' called for #<Binding:0x007fe1133b8548>

RUBY_VERSION # => 2.2.0
local_variables # => [:a, :b]
binding.eval('local_variables') # => [:a, :b]
binding.local_variables # => [:a, :b]
