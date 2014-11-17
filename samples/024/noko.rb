require 'open-uri'
require 'bundler/setup'
Bundler.require

doc = Nokogiri::HTML(open('http://allabout.co.jp/').read)
doc.class # => Nokogiri::HTML::Document
doc.class.ancestors
# => [Nokogiri::HTML::Document,
#     Nokogiri::XML::Document,
#     Nokogiri::XML::Node,       # Nodeを継承している
#     Enumerable,
#     Nokogiri::XML::PP::Node,
#     Object, PP::ObjectMixin, Kernel, BasicObject]
