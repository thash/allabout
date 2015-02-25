RUBY_VERSION #=> 2.1.2
Math.log(Math::E, -2) #=> NaN

RUBY_VERSION #=> 2.2.0
Math.log(Math::E, -2)
#=> Math::DomainError: Numerical argument is out of domain - "log"
