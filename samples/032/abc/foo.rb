require_relative 'def/bar'
p Bar.new

# 以下のように書くのと同じ効果
require File.expand_path('def/bar', File.dirname(__FILE__))
