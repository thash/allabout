def iter
  puts '------------'
  yield
  puts '============'
end

iter do
  puts 'hey'
end
#=> ------------
#=> hey
#=> ============

# 何回でもブロックを実行できます
def iter3
  yield
  yield
  yield
end

iter3 do
  puts 'fuga'
end
#=> fuga
#=> fuga
#=> fuga


iter #=> `iter': no block given (yield) (LocalJumpError)
