n = rand(1000)
puts "n = #{n}"

if (n > 500) then
  puts 'big!'
end

# カッコとthenは省略可能で、ふつうはこう書きます。
if n > 500
  puts 'big!'
end

if n.odd?
  puts '奇数'
else
  puts '偶数'
end

if n % 15 == 0
  puts 'FizzBuzz'
elsif n % 3 == 0
  puts 'Fizz'
elsif n % 5 == 0
  puts 'Buzz'
end
