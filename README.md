Requirements
================================================================================

* phantomjs
* allabout guide id


Usage
================================================================================

1. Fix up conf.json.

```
$ cat conf.json
{
  "guideid": "xxxxx",
  "passwd": "xxxxxxxxxx",
  "guidesiteid": "xxxx"
 }
```

2. Write an article.

3. Execute.

Pass article id and html as arguments.

```
$ phantomjs upload.coffee 439246 articles/aa003_rubygems.html
```


TODO
================================================================================

* call from markdown-mode.
* parse related yml and fill up metadata.
* create new article.


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
