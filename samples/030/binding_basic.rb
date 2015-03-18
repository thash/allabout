RUBY_VERSION #=> "2.1.2"
a = 1
bnd = binding #=> #<Binding:0x007fdaab3f3788>
bnd.eval('local_variables') #=> [:bnd, :a, ...]
bnd.local_variables         #=> NoMethodError: private method `local_variables' called for #<Binding:0x007fdaab3f3788>


RUBY_VERSION #=> "2.2.0"
a = 1
bnd = binding #=> #<Binding:0x007f99ce089b88>
bnd.eval('local_variables') #=> [:bnd, :a, ...]
bnd.local_variables         #=> [:bnd, :a, ...]
