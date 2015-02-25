RUBY_VERSION #=> 2.1.2

{ "super-key": 1, "hyper-key": 2 }
# => SyntaxError: unexpected ':', expecting =>
#    { "super-key": 1, "hyper-key": 2 }
#                  ^

# こう書く必要があった
{ :"super-key" => 1, :"hyper-key" => 2 }
# => {:"super-key"=>1, :"hyper-key"=>2}


RUBY_VERSION #=> 2.2.0
{ "super-key": 1, "hyper-key": 2 }
#=> {:"super-key"=>1, :"hyper-key"=>2}
