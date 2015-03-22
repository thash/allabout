2.upto(9) do |i|
  define_method "mul#{i}" do |val|
    i * val
  end
end

p mul2(3) # => 6
p mul9(3) # => 27
