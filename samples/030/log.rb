RUBY_VERSION #=> "2.2.0"

p Math.log(2.7)   #=> 0.9932517730102834
p Math.log(2.8)   #=> 1.0296194171811581
p Math.log(10, 2) #=> 3.3219280948873626

p Math.log(10, -2)
#=> Numerical argument is out of domain - "log" (Math::DomainError)
