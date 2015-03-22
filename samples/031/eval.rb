eval 'puts "hoge"' # => hoge

2.upto(9) do |i|
  eval <<-CODE
    def mul#{i}(val)
      #{i} * val
    end
  CODE
end

p mul2(3) # => 6
p mul9(3) # => 27
