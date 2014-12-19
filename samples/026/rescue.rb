require 'date'

begin
  Date.new(2014, 12, 32)
rescue => e
  puts e       # => invalid date
  puts e.class # => ArgumentError
  print e.class.ancestors
  # => [ArgumentError, StandardError, Exception, Object, Kernel, BasicObject]

  Date.today
end


# begin ... endは値を返すので、次のような使い方もできる
day = begin
        Date.new(2014, 12, 32)
      rescue
        Date.today
      end

puts day # => 2014-12-19
