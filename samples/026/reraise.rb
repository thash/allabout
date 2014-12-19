begin
  do_something
rescue => e
  # if条件が成り立てば救済したいが、
  return nil if # ...
  # それ以外の時はもう一度raiseする
  raise e
end

# 「raise => e」で変数に束縛する代わりに、
# 一番最後に起こった例外を指す予約変数 $! を使っても良い
begin
  do_something
rescue
  raise $!
end
