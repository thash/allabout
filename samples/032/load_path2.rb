# LOAD_PATH以下にprime.rbがある
p $LOAD_PATH.select {|path|
  File.exist?(path + '/prime.rb')
}
#=> ["/Users/hash/.rbenv/versions/2.1.2/lib/ruby/2.1.0"]


# $LOAD_PATHにカレントディレクトリを追加すれば、ファイル名だけでrequireできる
$LOAD_PATH << '.'
require 'require_b' #=> true
