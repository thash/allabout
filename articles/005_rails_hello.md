### Ruby on Railsとは

Ruby on Railsは2004年ごろにDavid Heinemeier Hansson氏(通称DHH)らによって開発された、非常に人気のあるオープンソースのWebフレームワークで、Rubyを使ってWebアプリケーションを作成するための枠組みを提供してくれます。

<div class="center150 article_image_box"><img width="150" height="178" class="article_image" alt="Ruby on Rails logo" src="http://img.allabout.co.jp/gm/article/440344/Ruby_on_Rails-logo.png" /></div>

Railsで作られたWebサービスの例としては [CookPad](http://cookpad.com/)や[食べログ](http://tabelog.com/)、[Qiita](http://qiita.com/)などがあります。他にも [Ask.fm](http://ask.fm/)や[GitHub](http://github.com/)、[Hulu](http://www.hulu.com/)もRailsですし、今ではかなり有名になった[Twitter](http://twitter.com)も初期バージョンはRails製でした。

Railsの流儀に従ってプログラムすることで楽しく効率的にWeb開発を行うことができ、これを肯定的なニュアンスで「レールに乗る」と表現することがあります。
現在のWebは使われる技術も複雑になっており、ゼロから学んでいくと大変な時間がかかります。そこでまずは「レールに乗る」ことで正しい「型」を身に付け、なにか作れるようになったあとに理解を深めて独自の改良を加えていく... という順番が良いでしょう。スポーツや武道の上達プロセスに通じるところがあるかもしれません。

登場から10年以上経つ現在でも、[GitHub上のレポジトリ](https://github.com/rails/rails)で進められている開発は非常に活発です。執筆時点のバージョンは`v4.0.3`ですが、次のバージョン`v4.1.0`に向けて世界中のRubyエンジニアによって開発が進められています。


### Railsの哲学

先に「Railsの流儀」と書きましたが、Railsにはいくつかの「哲学」とでも呼ぶべき指針があります。以下、簡単に紹介します。

* Don't Repeat Yourself ... DRY(ドライ)の原則
    * 似たコードがいろいろな場所に散らばると、後々のメンテナンスが難しくなってしまいます。そこでRailsは「同じことを繰り返さない」というDRYの原則に従い、徹底的な抽象化・モジュール化を行うことで無駄コードの少ないフレームワークを実現しています。
* Convention over configuration ... 設定より規約(CoC)
    * ゼロから実際に動くアプリケーションを作成するまでには、たくさんのコードを書き、設定を行う必要があります。そこでRailsがあらかじめデフォルトのやりかた(= 規約)を決めておき、開発者はこの規約に従うことで設定を行う手間を省略し、少ないコード量でアプリケーションを動作させることが出来ます。

これらはRails思想の中核にあるとはいえ、実際にコードに触れてみないとなかなかピンと来ないと思います。しばらくRailsを学んだ後に思い出して「なるほどこれがDRYやCoCか」と思えればそれで良い、と軽く考えておいてください。


### RailsのMVCアーキテクチャ

Railsは「MVC」というアーキテクチャに基づいたフレームワークです。MVCとは設計パターンのひとつで、アプリケーションを「Model, View, Controller」の3つに分解することでコードの見通しをよく、保守性を高めることを目的とします。具体的にそれぞれの役割は以下のとおりです。

* Model: データ
    * アプリケーションが扱うデータ表現と、そのデータに関わる処理(ロジック)を担当する。
* View: ページ
    * ModelデータをHTMLとしてユーザに見せるための出力を担当する。
* Controller: 振り分け役
    * ユーザからのアクセスや入力を受け取り、ModelやViewに処理を指示する役割。

次ページ以降で実際に目にすることになりますが、Railsアプリケーションの実際のファイル構成はMVCアーキテクチャに沿ったものになります。

<!--また、Railsはよく「フルスタックのWebアプリケーションフレームワーク」とも言われます。「フルスタック」とは要するに「全部のせ」、必要なものが最初から満載されていることを意味します。これは初心者の学習コストを下げて開発の初速を上げてくれる一方、実際に使われない不要な機能もごちゃごちゃと付けたまま動かすことになりがちです。まずはRailsを学んでWebアプリケーションに対する理解が深まって来たら、フルスタックではない軽量な[Sinatra](http://www.sinatrarb.com/)などを使って比較してみるのも良いでしょう。-->

[次のページ](/gm/gc/440344/2/)では、Railsをインストールする方法を紹介します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Railsのインストール

RailsはRubyGemsのパッケージとして提供されているので、`gem install rails`コマンドでインストールすることが出来ます。以下、小文字のrailsはgem名あるいはコマンド名を表し、大文字始まりのRailsと書くときはフレームワークを指します。

RubyGemsについては以前の記事 [RubyGems (gem) の使い方・インストール方法 [Ruby] All About](http://allabout.co.jp/gm/gc/439246/) を参考にして下さい。

<script src="https://gist.github.com/memerelics/163e1d923f0be232cd57.js?file=rails-install.sh"></script>

railsのインストールにはやや時間がかかります。途中経過を見たい時はインストール時に`-V`オプションを付けて`gem install -V rails`としてみるとよいでしょう。
さて、`rbenv rehash`を実行してから`rails`コマンドを試してみます。正しくインストールされていれば以下のように使い方のオプションが表示されるはずです。

<script src="https://gist.github.com/memerelics/163e1d923f0be232cd57.js?file=rails-command.sh"></script>

上では`rails new`のヘルプが表示されています。`new`はrailsのサブコマンドで、Railsアプリケーションのひな形を生成してくれます。

new以外にもrailsの後に`rails <subcommand>`と続けることで使えるいろいろなサブコマンドがあります。以下によく使うものを簡単に紹介します。


* `rails new`
  * Railsの新規プロジェクトを作成します。
* `rails generate`
  * Railsの提供するテンプレートに基づき Model, Controller, scaffold などを生成します。
* `rails server`
  * [WEBRick](http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html) Webサーバを起動します。お手軽なRails開発環境として重宝します。
* `rails console`
  * Rails環境をロードした状態で対話的実行環境を起動します。
* `rails runner`
  * Rails環境をロードした状態でバッチ処理を実行させます。cronなどに使います。


[次のページ](/gm/gc/440344/3/)では実際にRailsアプリケーションを作成して、その構成を簡単に説明して行きます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Railsプロジェクトの作成


それではいよいよ、最初のRailsアプリケーションを作ってみましょう。手元で試してみる場合はあらかじめテストアプリケーションを作成するディレクトリを決めておき、自分の好きな場所に`rails new <application-path>`してください。

`rails new`の途中、`run bundle install`の行で依存するgemを自動的にインストールするため出力が止まるように見えます。焦らずしばらく待ちましょう。

<script src="https://gist.github.com/memerelics/163e1d923f0be232cd57.js?file=rails-new.sh"></script>

`hello-rails`というディレクトリの下に大量のディレクトリとファイルが生成されました。最初からすべての意味を知ろうとすると挫折してしまうので、重要と思われるものだけを抜き出したのが以下の図です。

<script src="https://gist.github.com/memerelics/163e1d923f0be232cd57.js?file=rails-dir.sh"></script>


### Gemfile

`Gemfile`と`Gemfile.lock`はBundlerがRubyGemsを管理する時に使われるファイルです（何のことかわからない人は、過去の記事 [Bundlerの使い方・Gemfileの書き方 [Ruby] All About](http://allabout.co.jp/gm/gc/439606/) を参考にして下さい）。Gemfileの中を覗くと次のようなgemが使われているのがわかります(コメント行は無視しています)。`rails`本体のほか、軽量データベースの`sqlite3`、[CoffeeScript](http://coffeescript.org/)をRailsで使うための`coffee-rails`などが、Railsアプリケーションを作成するとデフォルトで使用されます。

このように「Webアプリケーションを作るならこのあたりが必要になるだろう」あるいは「Railsが推奨する技術はコレだよ」というgemたちがあらかじめパッケージに含められているのもRailsの特徴です。

<script src="https://gist.github.com/memerelics/163e1d923f0be232cd57.js?file=Gemfile.rb"></script>


### appディレクトリとMVC

appディレクトリ以下はRailsアプリケーションの本体コードが入ります。開発作業をするなかで一番いじることが多いディレクトリです。
また、appの下に`controllers`、`models`、`views`というディレクトリが作成され、それぞれの下にはMVCモデルに対応するコードが格納されることになります。


### configディレクトリ

config以下は文字通り設定ファイルなどを格納します。`application.rb`にはRailsアプリケーション自体の設定値が入り、`environments`ディレクトリ以下の`development.rb`と`production.rb`などはそれぞれ開発環境、本番環境で値を切り替える設定を書きます。


### dbディレクトリ

dbディレクトリ以下には現在のデータベーススキーマや、スキーマの変更履歴が「migration」ファイルとして蓄積されていきます。


### testディレクトリ

testディレクトリ以下には、Railsアプリケーションのテストコードが入ります。Railsはテストを書くことが強く推奨されているため、今後の連載で扱う機会もあるかもしれません。


最後に[次のページ](/gm/gc/440344/4/)では、このアプリケーションを起動させて、Railsの導入を締めくくりましょう。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Railsアプリケーションを起動する


それではいよいよRailsアプリケーションを起動してみましょう。`bundle exec rails server`コマンドを実行してください。なお`bundle exec`とは「Bundlerでインストールされた（Gemfileに記載された）gemのコマンドを実行する」という指令です。

<script src="https://gist.github.com/memerelics/163e1d923f0be232cd57.js?file=rails-server.sh"></script>

これでRailsアプリケーションが起動しました。アクセスするには、ブラウザから `http:/127.0.0.1:3000/` にアクセスしてみてください。以下の様なページが見えれば成功です。

<div class="center150 article_image_box"><img width="150" height="165" class="article_image" alt="You're riding Ruby on Rails!" src="http://img.allabout.co.jp/gm/article/440344/rails_server.png" /> </div>


以上で今回の記事は終わりです。Railsというフレームワークの紹介に始まり、インストールから最初の起動まで駆け足で見てきましたがいかがでしょうか。なんとなく雰囲気は伝わったかもしれませんが、まだアプリケーションを「作った」感じがしないと思います。

次回からはコードを書きRailsに乗るステップに進んでいきますので、ご期待ください。

