Requirements
================================================================================

* phantomjs
* allabout guide id


Usage
================================================================================

```
$ cat conf.json
{
  "guideid": "xxxxx",
  "passwd": "xxxxxxxxxx",
  "guidesiteid": "xxxx"
 }
```

### How to create new article

```
$ phantomjs upload.coffee create articles/aa003_rubygems.json
```

JSON-formated meta information comes out something like this:

```
{
    "titleShort" : "Bundlerの使い方",
    "title" : "Bundlerの使い方",
    "abstract" : "プロジェクト単位でRubyGemsを管理するBundlerの使い方を紹介します。",
    "keywords" : [ "ruby",
                   "bundler",
                   "bundle",
                   "gem",
                   "パッケージ管理" ]
}
```


### How to update existing article

Pass article id and html as arguments.

```
$ phantomjs upload.coffee update 439246 articles/aa003_rubygems.html
```

Meta information will be also updated if `articles/aa003_rubygems.json` exist.


TODO
================================================================================

* upload image
* set summary image


AllAbout HTML
================================================================================

### embed gist for code snippet

Because AA admin system has no syntax highlighting feature, I'm using Gist.

```
<script src="https://gist.github.com/memerelics/7904194.js" type="text/javascript"></script>
```

or for single file,

```
<script src="https://gist.github.com/memerelics/7904194.js?file=hoge.rb" type="text/javascript"></script>
```


### new page

```
<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>
```

### Amazon Item

Embed div with name and class. Here name value should be like `Item:0003:<ASIN ID>`, then amazon item will be embedded automatically.

```
<div name="Item:0003:4873113946" class="ItemCassette">プログラミング言語 Ruby</div>
```


Memo
=========================

dump html for debug.

```
fs.write('aa5.html', page.content, 'w') if conf.debug
```
