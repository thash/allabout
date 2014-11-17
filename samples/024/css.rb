# Nokogiri::XML::Node#css, および Nokogiri::XML::Node#xpath は
# Elementのまとまりである「Nokogiri::XML::NodeSet」を返す
doc.css('ul#sys-topwaku-topix li')
doc.xpath('//ul[@id="sys-topwaku-topix"]/li')

# Nokogiri::XML::NodeSetはEnumerableなので、eachやmapで各Elementにアクセスできる
doc.css('ul#sys-topwaku-topix li').each do |li|
  puts  "[#{li.text}](#{li.at(:a).attr(:href)})"
end
# => [稼げる旦那、判断のためのポイント5つ](http://allabout.co.jp/matome/cl000000005902/)
#    [あなたが運動しても痩せない理由](http://allabout.co.jp/newsdig/c/74939)
#    [就職に有利な使える資格ランキング](http://allabout.co.jp/matome/cl000000005395/)
#    [独身者よりカップルの方が長生きする？](http://allabout.co.jp/gm/gc/301665/)
#    [「拝見させていただく」はNG敬語](http://allabout.co.jp/matome/cl000000005866/)
#    [大阪で見たい「おもろい看板」7選](http://allabout.co.jp/matome/cl000000005637/)
#    [恋人との問題、見て見ぬふりで大丈夫？](http://allabout.co.jp/gm/gc/449062/)
