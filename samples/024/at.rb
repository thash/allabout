# Nokogiri::XML::Node#at メソッドは検索結果の最初のヒットを返す
doc.at('title')
# => #(Element:0x3feb0890f99c { name = "title", children = [ #(Text "All About（オールアバウト）")] })
doc.at('title').class # => Nokogiri::XML::Element
