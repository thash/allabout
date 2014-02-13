Requirements
================================================================================

* phantomjs
* allabout guide id


Usage
================================================================================

(1). Fix up conf.json.

```
$ cat conf.json
{
  "guideid": "xxxxx",
  "passwd": "xxxxxxxxxx",
  "guidesiteid": "xxxx"
 }
```

(2). Write an article.

(3). Execute.

Pass article id and html as arguments.

```
$ phantomjs upload.coffee 439246 articles/aa003_rubygems.html
```

or, create new article.

```
$ phantomjs upload.coffee new articles/aa003_rubygems.json
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


Memo
=========================

dump html for debug.

```
fs.write('aa5.html', page.content, 'w') if conf.debug
```
