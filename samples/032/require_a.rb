# ファイル名だけでは読み込めない
# require 'require_b'
# => in `require': cannot load such file -- require_b (LoadError)

# カレントディレクトリ(.)を書く必要がある
require './require_b' #=> true  (読み込み成功)
require './require_b' #=> false (読み込み済なので何もしない)

# 別ファイルで定義したクラスが使える
p B.new #=> #<B:0x007ffc51888088>
