### Bundlerとは ###

[Bundler](http://bundler.io/) は、Rubyアプリケーションの動作に必要なgemを束ね(bundle)て、依存関係を管理するためのツールです。

* アプリケーションの依存するgem一覧をファイル（後で出てきますが、これをGemfileと呼びます）で指定するため、利用gemをソースコードと一緒にバージョン管理システムで管理できる
* 他の作業者が環境構築する時や、しばらくコードの更新が止まっていたプロジェクトを再開する時に起こりがちな依存ライブラリ問題を回避し、すぐに「動く状態」までもって行きやすい

...など、長期的・現実的にRubyアプリケーション開発を行う時の問題を解決してくれるため、2014年2月現在、Rubyを用いた開発のデファクトスタンダードとなっています。


### Bundlerのインストール ###

Bundler自体はRubyGemsを使って、次のように`gem install bundler`コマンドでインストールします。
RubyGemsについては[前回の記事「RubyGems (gem) の使い方・インストール方法」](http://allabout.co.jp/gm/gc/439246/)を参考にして下さい。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=install.sh"></script>

インストールが成功すると、`bundle`コマンドが使えるようになります。`which bundle`コマンドで実行ファイルが見つかればOKです。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=which.sh"></script>


[次のページ](/gm/gc/439606/2/)では、Bundler利用のキモとなるGemfileの書式を解説します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Gemfileの書き方 ###

Bundlerは、 "Gemfile" と名付けたファイルにアプリケーションの使用するgemを列挙して管理します。最初に`source`でgemの取得先を定義します

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=source.rb"></script>

次に、利用するgemを次のような書式で宣言します。例としてここでは"rack"というgemを使いたいとしましょう。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=rack.rb"></script>

こうすると、利用可能な中で最新バージョンのrackがインストールされます。

また、利用するgemのバージョンを限定することもできます。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=eq.rb"></script>

これは必ずバージョン1.4.0のrackを使うように、という指定です。さらに「1.4.0移行のバージョンでなるべく新しいもの」を使いたい場合は

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=gte.rb"></script>

このように書きます。最後に、少し特殊な(しかしよく使われる)書き方として`~>`があります。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=nami.rb"></script>

この表記は `gem 'rack', '>=1.4.0'` かつ `gem 'rack', '< 1.5'` を意味します。つまり1.4.0よりも新しいバージョンを使いたいが、たとえ利用可能であっても1.5よりも上は使いたくない、という条件を指定したことになります。メジャーバージョンアップをまたぐと大きくgemの動作が変わることがあるので、gemを新しくしすぎてアプリケーションを破壊しないようによく使われる書き方です。


[次のページ](/gm/gc/439606/3/)では実際にBundlerを使ってgemをインストールする方法を紹介します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Bundlerを使ってgemをインストールする ###

プロジェクトを開始するディレクトリを作成し、そこで`bundle init`コマンドを実行するとGemfileが生成されます。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=init.sh"></script>

Gemfileの中にはサンプルだけが書かれています。このGemfileを以下のように編集します。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=gemfile.rb"></script>

ここでは例として[PowerBar](https://github.com/busyloop/powerbar)というgemを使っています。

Gemfileを編集し終わったら、`bundle install`コマンドでgemをインストールします。この際、`--path`オプションでインストールディレクトリを指定するのを忘れないようにしてください。一度行った`--path` 指定は`.bundle/config`ファイルに記録され、次回以降は単に`bundle install`だけで同じ場所にインストールされるようになります。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=bi.sh"></script>

指定した覚えのない`hashie`, `ansi`というgemもインストールされていますが、これらは`powerbar`が依存する(内部で利用している)gemたちです。`vendor/bundle`の下を覗いてみると、これらのgemがインストールされているのがわかります。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=tree"></script>

さて、`bundle install`を実行した後、Gemfileと同じディレクトリにGemfile.lockというファイルが生成されていることに気付いたかもしれません。この中を覗いてみると、

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=lock"></script>

Bundlerが自動的に解消したgem同士の依存関係と実際にインストールされたバージョンが記録されています。Gemfile.lockはgit(等のバージョン管理システム)に含めるようにしてください。

ここで`bundle check`を叩いてみると、

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=check"></script>

`The Gemfile's dependencies are satisfied`と表示され、「新しくインストールするgemはないよ」と教えてくれます。プロジェクトで新しく利用するgemが増える時は、Gemfileに`gem 'gemname'`を1行追加して`bundle check`したあと、`bundle install`を実行して下さい。


[次のページ](/gm/gc/439606/4/)ではBundlerを使ってインストールしたgemを実際のコード中で利用するためにはどう書けばよいか説明します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Bundlerでインストールしたgemの利用方法 ###

`pb.rb`というRubyファイルを作成します。この中で先ほどインストールした`PowerBar`を使ってみます。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=pb.rb"></script>

`require 'bundler'`した後に`Bundler.require`とすれば、Gemfileに記載されたgemをすべてrequireすることができます。

PowerBarはRubyで簡単にプログレスバーを出力するためのgemで、ここでは0.1秒ごとに1メモリ進んでいくダミーのプログレスバーを作って表示しています。出力は以下のようになります。

<script src="https://gist.github.com/memerelics/d0f70e3e9742d5e83474.js?file=exec"></script>


### bundle その他の機能 ###

Bundlerには他にもいろいろなコマンドがあるので、以下に簡単な説明を挙げます。

* `bundle update`
    * インストールしたgemの新しいバージョンが利用可能であれば最新版に更新します。
* `bundle exec <cmd>`
    * bundleでインストールしたgemのコマンドを実行します。
* `bundle show <gem>`
    * gemインストールされた場所(フルパス)を表示します。
* `bundle open <gem>`
    * gemインストールされたディレクトリをエディタで開きます。
* `bundle clean`
    * Gemfileの指定を調べて、現在使われていないgemを削除します。

詳しくは`bundle help`、あるいは`bundle help <command>`でマニュアルを参照してください。


以上がBundlerの基本的な使い方です。Rubyを使うなら是非慣れておいてください。今後の連載でも、具体的にRubyアプリケーションを作成する時はBundlerを使っていきます。
