### gemとは

gem (じぇむ、正式には[RubyGems](https://rubygems.org/))は、Rubyで書かれたアプリケーションやライブラリを簡単に扱うためのパッケージ管理システムで、個々のパッケージを"gem"として管理します。Perlで言うCPAN, PHPで言うPEARやPECLに近いでしょうか。

RubyGemsは、Ruby1.9より新しいバージョンのRuby本体をインストールすると標準で付いて来ますので、以降の内容を実際に試しながら読みたい方は、前回の記事([Rubyのインストール（rbenvを使った方法） [Ruby] All About](http://allabout.co.jp/gm/gc/431930/))を参考にしてRubyをインストールして下さい。


### インストール済gemの一覧

gemを操作するにはコンソールから`gem`コマンドを使います。まずは`gem list`コマンドを叩いて現在自分の環境にインストールされているgemの一覧を見てみます。

<script src="https://gist.github.com/memerelics/12d0166025bd83e98c77.js?file=gemlist.sh"></script>

何もインストールした覚えがなくても上記のパッケージ名が出てくると思いますが、これはRuby本体をインストールした時に付属してくる標準gemで、メンテナンス性を考えてRuby本体からgemの形で分離されているライブラリたちです。
※`rake`と`minitest`は今後の連載で扱う予定です。


[次のページ](/gm/gc/439246/2/)ではrubygems.orgから目的のgemを検索し、インストールする方法を紹介します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### gemを検索する

`gem search <word>`コマンドで、wordを名前に含むgemをrubygems.orgから検索して

<script src="https://gist.github.com/memerelics/12d0166025bd83e98c77.js?file=gemsearch.sh"></script>

この検索単語には正規表現を渡すことも可能で、例えば次のように"rails4"から始まるgemだけを探すこともできます。

<script src="https://gist.github.com/memerelics/12d0166025bd83e98c77.js?file=gemsearch2.sh"></script>


### gemをインストールする

それでは実際に、[Hashie](https://github.com/intridea/hashie)というgem(使い方は次のページで紹介します)をインストールしてみましょう。

<script src="https://gist.github.com/memerelics/12d0166025bd83e98c77.js?file=geminstall.sh"></script>

これでgemが利用可能になりました。`gem list`の結果に"hashie"が含まれているのがわかります。

<script src="https://gist.github.com/memerelics/12d0166025bd83e98c77.js?file=gemlist2.sh"></script>

なおRubyをrbenvでインストールした場合は、`gem install`後に以下のコマンドを実行する必要があるので注意して下さい。

<script src="https://gist.github.com/memerelics/12d0166025bd83e98c77.js?file=rehash.sh"></script>

[次のページ](/gm/gc/439246/3/)で、インストールしたgemを実際に利用してみます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### インストールしたgemを利用する

それでは、先ほどインストールしたhashieを利用してみましょう。`irb`と入力してirbプロンプトが表示されたら、以下のコードを実行します。

hashieを使うと、Hashのようにもオブジェクトのようにも扱えるデータ構造を定義することが出来ます。

<script src="https://gist.github.com/memerelics/12d0166025bd83e98c77.js?file=mash.rb"></script>

ちなみに、Ruby1.8以前はgemを利用するためにまず`require 'rubygems'`する必要がありましたが、1.9からはrubygemsがRuby本体に含まれるようになったため不要です。いきなり`require 'hashie'`を実行すればhashieをロードすることが出来ます。


### Bundler

以上がRubyGemsの基本的な使い方です。
今回はgemの基本を紹介しましたが、2011年ごろから"[Bundler](http://bundler.io/)"というツールを使ってgemを管理することが一般的になっているため、次回はこのBundlerを紹介します。

