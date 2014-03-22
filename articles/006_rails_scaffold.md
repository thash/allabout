### TwitterのようなものをRailsで作ってみよう

前回の記事 [Ruby on Railsの紹介 -- RailsのインストールとHello World [Ruby] All About](http://allabout.co.jp/gm/gc/440344/) ではRuby on Railsをインストールして起動する方法を学びました。

次は、何回かに分けてRailsを使ったアプリケーションを作成する手順を解説してみようと思います。作成するアプリケーションは"Twitter"を真似たものです。

[Twitter](https://twitter.com/) は(説明するまでも無いかもしれませんが)、簡単に言うとユーザが140文字の短いテキストを投稿して、それを読んだり読まれたりお気に入りしたり拡散して交流するWebサービスです。

Twitterを題材に選んだのは、もちろん使っている人が多いため完成イメージを共有しやすいという理由もありますが、コア部分はシンプルでありながら拡張できる機能が豊富で、出来上がりを逐一確認しながら進める段階的チュートリアルに向いているという考えによるものです。



### 新規アプリケーションの作成

まずは前回の記事と同じように、新規アプリケーションを作成します。Railsで作るTwitterなので安直に"Rwitter"とでもしましょうか。`--skip-bundle`をつけると`rails new`時にBundlerで依存gemを自動的にインストールする機能をスキップさせることが出来ます。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=railsnew.sh"></script>

作成された`Rwitter`ディレクトリに入ったら、先ほどスキップした`bundle install`を、インストールディレクトリを指定した上で実行します。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=bi.sh"></script>

この時点で、`rails server`コマンドで出来たてのアプリケーション画面を見ることが出来るのは前回解説した通りです。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=railss.sh"></script>

ここまでは復習でした。次はRailsの機能のひとつ「Scaffold」を使い、MVCモデルの基本的な作り方を学習します。



### Scaffoldとは

「Scaffold」という単語は「土台」とか「足場」という意味を持ちます。あるリソースのModel、View、Controller一式を自動的に生成してくれる機能で、その名の通り「足場」、完成形を作り上げるための叩き台として利用します。[GoogleでScaffoldを画像検索](https://www.google.com/search?q=scaffold&tbm=isch)するとよくわかりますが、ビルの工事でビル周辺に作られるあの骨組みをイメージするとよいでしょう。ビルを作るために組み立てられ、最終的には取り壊される"補助輪"です。

Railsでのアプリ作成に慣れてくると使わなくなりますが、最初はscaffoldを使ってみるのをオススメします。

[次のページ](/gm/gc/440949/2/)ではScaffoldを使うコマンドを紹介し、生成されたテンプレートに解説を加えていきます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### scaffoldの実行

Scaffoldは `rails generate scaffold <Model> <field>:<type>` というコマンドで実行します。例えば以下の例は、bodyというフィールドを持つ投稿（Post）モデルのscaffoldを作成しています。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=gen.sh"></script>

大量のファイルが作成されたのがわかります。それぞれの役割は以下の通りです。


* db/migrate/20140325013007_create_posts.rb
    * DBの変更(テーブル作成、カラム変更など)を行うマイグレーションファイル
* app/models/post.rb
    * PostリソースのModelを定義する
* test/models/post_test.rb, test/controllers/posts_controller_test.rb
    * ModelやControllerに対応するテストを記述する
* config/routes.rb
    * ルーティング定義(ユーザのアクセスをControllerのアクションに割り振る)
* app/controllers/posts_controller.rb
    * アクセスを受けて実行する処理を定義
* app/views/posts/{index.html.erb,edit.html.erb,show.html.erb,new.html.erb}
    * 各アクションごとに用意されたHTMLのテンプレート
* app/helpers/posts_helper.rb
    * Postリソースに関係するヘルパーメソッドを定義
* app/assets/javascripts/posts.js.coffee
    * PostのViewで実行されるCoffeeScriptを記述
* app/assets/stylesheets/posts.css.scss
    * PostのViewに適用されるスタイルを定義
* app/assets/stylesheets/scaffolds.css.scss
    * Scaffoldで生成したテンプレート用のスタイル


### migrationでDBを更新する

Railsの開発環境はデフォルトでsqlite3というデータベースを利用するようになっており、`Rwitter/db/development.sqlite3`がデータベースの本体です。

migrationはデータベースへの変更を抽象化し、rakeタスク`db:migrate`で実行します。rakeについては過去の記事( [RubyのMake、Rakeの使い方 [Ruby] All About](http://allabout.co.jp/gm/gc/439680/) )を参照してください。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=migrate.sh"></script>

これでデータベースが更新されました。sqlite3コマンドを使えばデータベースの中身を覗けるので、なにが出来たか見てみましょう。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=sqlite"></script>

Postリソースを格納する「posts」テーブルが作成され、text型のbodyというカラムが定義されているのがわかります。他に`created_at`、`updated_at`というカラムも存在していますが、これはRailsが標準で準備する、データの作成/更新日時を記録するカラムです。また、`schema_migrations`テーブルはmigrationステータスを格納する管理用テーブルです。


[次のページ](/gm/gc/440949/3/)では作成された画面とコードを見比べながら、RailsのルーティングとMVCのデータフローを理解していきます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Rails MVC & ルーティング

前のページでデータベースを更新したので、Postに関係するページが利用できるようになっています。

scaffold実行時に`config/routes.rb`ファイルに`resources :posts`の1行が追加されており、

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=routes.rb"></script>

この1行だけで[RESTful](http://ja.wikipedia.org/wiki/REST)なルーティングが用意されます。`bundle exec rake routes`コマンドを使って現在のルーティングを確認してみましょう。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=routes.sh"></script>

この出力は、`http://localhost:3000/posts`にアクセスするとPostsControllerのindexアクションがリクエストを処理し、`http://localhost:3000/posts`にPOSTリクエストを送るとPostsControllerのcreateアクションに処理が渡される、という対応付けを示しています。実際に`http://localhost:3000/posts`にアクセスしてみると次のようなページが見えると思います。

<div class="center200 article_image_box"><a title="posts" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/440949/posts.png"> <div class="BRClearAllClass"><br class="articleFloatClear" /> &nbsp;</div> <img width="200" height="122" class="article_image" alt="posts" src="//img2.allabout.co.jp/gm/article/440949/posts.png" /></a> <p class="cap">posts</p> </div>

アクションはController内にメソッド定義の形で記述されています。たとえばPostsControllerのindexアクションは以下の通りです。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=posts_controller.rb"></script>

そしてindexアクションの結果は、`app/views/posts/index.html.erb`ファイルに渡され、ユーザの目に見えるHTMLを生成します。`.html`の後に`.erb`がついていて奇妙に感じたかもしれませんが、これはERBと呼ばれ、通常のHTMLの中に`<% %>`や`<%= %>`のような形でRubyコードを埋め込めるテンプレートエンジンです。

<script src="https://gist.github.com/memerelics/a5fd0ec1491f1b265e4d.js?file=index.html.erb"></script>

`PostsController#index`で定義された`@posts`インスタンス変数を受け取り、`index.html.erb`の中でeachを回しているのがわかります。何かデータを入れてみましょう。`New Post`をクリックすると次のような投稿画面に移動します。

<div class="center200 article_image_box"><a title="newpost2" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/440949/newpost2.png"> <div class="BRClearAllClass"><br class="articleFloatClear" /> &nbsp;</div> <img width="200" height="142" class="article_image" alt="newpost2" src="//img2.allabout.co.jp/gm/article/440949/newpost2.png" /></a> <p class="cap">newpost2</p> </div>

適当な文字を入れて`Create Post`ボタンを押す手順を何度か繰り返すと、先ほど何もなかった`/posts`画面にデータが表示されました。

<div class="center200 article_image_box"><a title="posts2" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/440949/posts2.png"> <div class="BRClearAllClass"><br class="articleFloatClear" /> &nbsp;</div> <img width="176" height="150" class="article_image" alt="posts2" src="//img2.allabout.co.jp/gm/article/440949/posts2.png" /></a> <p class="cap">posts2</p> </div>


デザインは無いに等しく、このまま「完成形」として人前に出せるものではありませんが、コードを1行も書かずに「一覧表示」「投稿フォーム」「変更/削除機能」を用意出来てしまうのがscaffoldの面白いところです。Railsを学習し始めたばかりの人はまずscaffoldでテンプレートを生成し、それをいじりながら仕組みを覚えていくのがオススメです。

ここまでで、scaffoldとRailsのコードの流れをひとめぐりできました。
次回からはコードに手を入れてTwitter(のようなもの)の作成を続けて行こうと思います。

