class Clazz
  def my
    'defined in clazz'
  end
end

module MyModule
  refine Clazz do
    p self           #=> #<refinement:Clazz@B>
    p self.class     #=> Module
    p self.ancestors #=> [#<refinement:Clazz@B>, Clazz, Object, Kernel, BasicObject]
    def my
      'overwritten in module B'
    end
  end
end

module MyModule2
  using MyModule
  p Clazz.new.my #=> "overwritten in module B"
  def call_clazz_my
    Clazz.new.my
  end
end

class CustomClazz
  include MyModule2
end

p Clazz.new.my #=> "defined in clazz"
p CustomClazz.new.call_clazz_my #=> "overwritten in module B"
