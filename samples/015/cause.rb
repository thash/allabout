p RUBY_VERSION #=> "2.1.1"

class MyAppException  < StandardError; end

def divide100(n)
  100 / n
rescue
  raise MyAppException.new('My application is facing exception in divide100')
end

begin
  p divide100(50) #=> 2
  p divide100(20) #=> 5
  p divide100(2)  #=> 50
  p divide100(0)
rescue => e
  p e             #=> #<MyAppException: My application is facing exception in divide100>
  p e.cause       #=> #<ZeroDivisionError: divided by 0>
  p e.cause.cause #=> nil
end

