### SlimとERB

[Slim](http://slim-lang.com/)はHTMLテンプレートエンジンの一つです。テンプレートエンジンとは、テンプレートファイルにデータを当て込んで、動的にドキュメントを出力する仕組みです。

本記事のテーマはSlimですが、まずテンプレートエンジンの先輩格である「ERB」について説明させてください。

Ruby界隈では、長らくERBというテンプレートエンジンが使われてきました。今でもRubyビルトインライブラリに含まれています。

ERBは`<% %>`あるいは`<%= %>` というタグの中にRubyコードを埋め込むことでドキュメントを動的にレンダリングします。以前の記事[RailsでTwitterクローンを作る(2) -- 画面レイアウトを整える](http://allabout.co.jp/gm/gc/441740/)で作成したRailsのViewから抽出した、以下の例を見てもらったほうがわかりやすいでしょう。投稿一覧(`@posts`)をtableの中に1行1行表示していく部分です。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=sample.erb"></script>

ちなみに、`<% %>`にはif文やeachなどHTMLに出力されない制御構造を書き、`<%= %>`で評価したRuby式はHTMLに出力されます。Rails等のWebアプリケーションで使った場合は、上のERBファイルにサーバ上でデータ(上の例で言うと`@posts`インスタンス変数)が当て込まれ、生成されたHTMLがユーザのブラウザに送信されることになります。

見て分かる通り、ERBの利点は「ほぼ普通のHTMLであり、学習コストが低い」ことです。

そして、これをSlimで書くと以下のように表現されます。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=sample.slim"></script>

ずいぶんとスッキリとして、同時に「タテに長く」なったと感じるのではないでしょうか。具体的に変わった点を挙げてみると、

* タグから`<>`がなくなっている
* 閉じタグがない代わりに、Pythonのようにインデントで構造を表現している
* `<% %>`の代わりに`-`、`<%= %>`の代わりに`=`でRuby式を書いている

といったところです。ERBと違って最初に文法を覚える必要はありますが、閉じタグや`class="..."`といった冗長な表現が排除されて"スリム"に書けるのがメリットです。

ちなみにHamlというテンプレートエンジンもSlimと同じくインデントで構造を表しますが、SlimはHamlよりも高速に描画されるのが利点です。


それでは、[次のページ](/gm/gc/443374/2/)でSlimの文法を紹介していきます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Slimの文法

Slimの文法の特徴は、コードの簡潔さと様々なニーズに応える柔軟性です。以下、簡単な例から始まり、文法のカスタマイズまで紹介します。

何もないところにおもむろに記述した単語は、HTMLタグとみなされます。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=title.slim"></script>

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=title.html"></script>

タグの内容が複数行にわたるときは、インデントを下げてその中に記述します。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=title2.slim"></script>

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=title2.html"></script>

テキストを記述するためには行頭に`|`(パイプ)を置く必要があることに注意してください。こうしないと`<現在時刻>`という斬新なタグが生成されてしまいます。

もしくは可読性が低くならなければ、RubyのStringのように`#{}`で式を埋め込むことも可能です。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=title3.slim"></script>

次に、前ページの例でも見たとおり、タグの後に`.`(ドット)を置くことでclass属性を付与することができます。同様に`#`がid属性になります。これらは[jQuery](http://jquery.com/)のDOMセレクタと同じなので使ったことのある人には覚えやすいのではないかと思います。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=tab.slim"></script>

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=tab.html"></script>

なお出力結果のHTMLは見やすいように適当に改行していますが、実際はSlimは改行・スペースのないべたっとしたHTMLを出力するので留意しておいてください。

また、タグを省略してclass, idの記法を使うとdiv要素になります。一応div要素を明示的に書くことも出来ます。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=div.slim"></script>

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=div.html"></script>

属性(attributes)は、`属性名="値"`という記法でタグの後にスペースを入れて記述します。その他、RubyのHashを使ったHaml的な書き方もあります。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=attr.slim"></script>

上の3種類の書き方はすべて、等しいHTMLに変換されます。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=attr.html"></script>

出力しないロジックは`-`を、評価結果を出力する場合は`=`を、HTMLエスケープしないで出力する場合は`==`をそれぞれRubyコードの前に付けます。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=logic.slim"></script>

また、複数行に渡るRubyコードをviewに埋め込むために、`ruby:`のあとにインデントを下げてRubyコードを書くことが出来ます。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=ruby.slim"></script>

その他、同様にして`javascript:`, `css:`, `coffee:`, `markdown:`なども埋め込むこともできます。

[次のページ](/gm/gc/443374/3/)では、Slimのカスタマイズ方法と、RailsアプリケーションでSlimを使う方法を紹介します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Slimのカスタマイズ

Slimを用途に応じてカスタマイズすることができます。たとえば、`.`でdivのclass、`#`でdivのid付きを生成する設定はshortcutと呼ばれており、以下のように追記することでclass, id以外の属性(attributes)も生成させることが出来ます。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=engine.rb"></script>

新しく定義した`&`, `$$`, `$`ショートカットを利用してみます。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=short.slim"></script>

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=short.html"></script>

コード中で頻出する属性やタグに気付いたら、ショートカットで記述を短縮することが出来るかもしれません。


### RailsテンプレートにSlimを使う

Ruby on Railsは標準では前述のERBをテンプレートエンジンに採用していますが、Slimを使えるように変更するのは簡単です。

まずGemfileに`gem 'slim'`を追記してインストール(`bundle install`)します。erbからslimに自動変換するために`html2slim`というgemも入れていますが、これは開発環境だけで使えればいいので`group: :development`を入れておきましょう。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=gemfile.rb"></script>

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=bi.sh"></script>

html2slim gemを入れると、html2slim, erb2slimの2つのコマンドが使えるようになります。erb2slimを使って、app/views以下のerbファイルをすべてslimに変換します。

<script src="https://gist.github.com/memerelics/b21c799d133c77707f90.js?file=find.sh"></script>

あとは不要になったerbファイルを削除すれば、RailsがSlimで動くようになります。


### 以上

以上、Slimの紹介でした。筆者は仕事では2年ほどHamlを使っていますが、個人的にはSlimがしっくり来たのでここのところプライベートではSlim派です。よく使われているのはHamlですが、Slimは後発テンプレートエンジンだけあっていろいろと改良が加えられていたりするので、気になる人は両方使い比べてみると良いかも知れません。
