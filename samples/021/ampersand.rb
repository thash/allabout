def iter(&b)
  p b          # => #<Proc:0x007fb92a934c30@ampersand.rb:6>
  p b.class    # => Proc
  p b.class.ancestors # => [Proc, Object, Kernel, BasicObject]

  # yieldの代わりにProc#callを使う
  b.call       # => hey
end

iter do
  puts 'hey'
end
