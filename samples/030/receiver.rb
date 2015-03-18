RUBY_VERSION # => 2.1.2
binding.eval('self') # => main
binding.receiver
#=> NoMethodError: undefined method `receiver' for #<Binding:0x007fe1159032f8>

RUBY_VERSION # => 2.2.0
binding.eval('self') # => main
binding.receiver # => main
