RUBY_VERSION #=> 2.2.0

p File.open('local_variables.rb').birthtime
# => 2015-02-20 07:29:10 +0900

p File.open('local_variables.rb').ctime

# File#mtimeは最終更新時間を返す
p File.open('local_variables.rb').mtime
# => 2015-02-21 01:26:17 +0900
