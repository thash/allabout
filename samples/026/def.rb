def hoge
  do_something
rescue => e
  # ...
end

# 次の用に明示的にbegin...endを書いても同じ動作となる
def hoge
  begin
    do_something
  rescue => e
    # ...
  end
end
