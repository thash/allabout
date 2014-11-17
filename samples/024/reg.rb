require 'open-uri'
html = open('http://allabout.co.jp/').read

# 正規表現
puts html.scan(/<title>.*<\/title>/) #=> <title>All About（オールアバウト）</title>
