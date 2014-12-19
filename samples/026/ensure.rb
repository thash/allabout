begin
  file = File.open('something.txt')
  # ... 本来やりたい処理
rescue
  # ... 何らかの救済処理
ensure
  file.close unless file.nil?
end
