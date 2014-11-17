require 'open-uri'
puts open('http://allabout.co.jp/').read # => WebページのHTMLをStringとして取得
