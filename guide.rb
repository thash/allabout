#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require

module Kernel; def delay(n=3); sleep n; end; end

class Article < Struct.new(:id, :title, :created, :published)
  def inspect; "#{id} : #{title} (#{created})"; end
end

Capybara.javascript_driver = :webkit
@s = Capybara::Session.new(:webkit)
@s.driver.header 'user-agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:26.0) Gecko/20100101 Firefox/26.0'

def visit_guide_page
  @s.visit 'https://gmtool.allabout.co.jp/g_login/index'

  conf = Hashie::Mash.load('./conf.json')

  @s.fill_in :guideid, with: conf.guideid
  @s.fill_in :passwd,  with: conf.passwd
  @s.click_on 'ログイン'
  delay

  @s.select 'Ruby', from: 'guidesiteid'
  @s.click_on '移動'
  delay

  @s.click_on 'コンテンツ管理'
  delay
end

def find_meta(article_file)
  ext = File.extname(article_file)
  json_file = "#{File.dirname(article_file)}/#{File.basename(article_file, ext)}.json"
  Hashie::Mash.load(json_file)
end

def update_meta(meta)
  @s.fill_in :txt_TitleShort, with: meta.titleShort
  @s.fill_in :txt_Title, with: meta.title
  @s.fill_in :txt_MetaDescription, with: meta.abstract
  @s.fill_in :txt_MetaKeywords, with: meta.keywords.join(', ')
end

def preview_url
  return 'no preview button' unless @s.has_field? :preview
  'https://' + @s.find(:css, 'input[value="PCプレビュー"]')[:onclick].scan(/\/\/(.*)',/).first.first
end

def export_html(mdfile)
  `markdown #{mdfile} > #{File.dirname(mdfile)}/#{File.basename(mdfile, '.md')}.html`
end

def content(file)
  htmlfile = case File.extname(file)
             when '.html' then file
             when '.md'
               export_html(file)
               "#{File.dirname(file)}/#{File.basename(file, '.md')}.html"
             end
  open(htmlfile).read.gsub(/^.*<body>(.*)<\/body>.*$/m) { $1 }
end

case ARGV[0].to_sym
when :list
  visit_guide_page
  table = @s.find :xpath, '//*[@id="gscontentslistTbl"]//tr[5]//table'

  articles = table.all(:css, 'tr').drop(1).map {|r|
    (2..5).map{|i| r.find(:css, "td:nth-child(#{i})").text }
  }.map{|item| Article.new(*item) }

  puts articles.map(&:inspect)

when :create
  exit 1 unless File.exist?(ARGV[1])
  exit 1 unless File.extname(ARGV[1]) == '.json'

  visit_guide_page
  @s.click_on '新規作成'
  delay

  update_meta(Hashie::Mash.load(ARGV[1]))
  @s.fill_in :txt_Article, with: '--'

  @s.driver.execute_script 'document.form.submit()'
  delay

  puts preview_url

when :update
  # $ guide.rb update <article_id> path/to/the/article.html
  exit 1 if ARGV.size < 3

  visit_guide_page
  @s.click_on ARGV[1] # 記事idが編集リンクになってるのでクリック

  update_meta(find_meta(ARGV[2]))
  @s.fill_in :txt_Article, with: content(ARGV[2])

  @s.driver.execute_script 'document.form.submit()'
  delay

  puts preview_url
end
