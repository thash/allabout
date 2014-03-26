### レイアウト・デザインを整える

前回の記事 [RailsでTwitterクローンを作る(1) -- Scaffoldでひな形を生成 [Ruby] All About](http://allabout.co.jp/gm/gc/440949/) では、Railsの提供するScaffold機能を使って投稿(post)リソースのModel, View, Controllerを生成しました。

今回はViewとControllerを中心に、RailsアプリケーションのUIを編集する手順を学びます。


### ページ遷移せずに投稿する

RailsがScaffoldで生成する設計はいわゆる「REST」スタイルに基づいたものですが、アプリケーションを作り進めて行くと、標準RESTスタイルからズレてくることがほとんどです。たとえば、Scaffoldで作った今の状態では別ページのフォーム(`/posts/new`)から新しい投稿を作成する必要がありますが、本家Twitterのように一覧ページを眺めながら新しい投稿ができると便利そうです。


<div class="center400 article_image_box"><a href="http://img.allabout.co.jp/gm/article/b/441740/ab.png" class="slide_image" rel="allabout-gallery" title="画面遷移図"><img src="http://img.allabout.co.jp/gm/article/441740/ab.png" width="400" height="151" alt="画面遷移図" class="article_image" /></a></div>


まずは新規作成ページ(new)を廃止して、一覧(index)にformを置いて投稿できるようにしましょう。新規作成ページを生成する`app/views/posts/new.html.erb`ファイルを見てみると、下のようにわずか3行しか書かれていません。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=new.html.erb"></script>

`render 'form'`という行に着目してください。これは「formという名前のpartial(断片)viewファイルをここに描画する」という命令です。partialファイルは`_`(アンダースコア)から始まります。`app/views/posts/`ディレクトリの中身を見てみると、確かに`_form.html.erb`というファイルが存在します。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=ls.sh"></script>

`app/views/posts/_form.html.erb` の内容は次のようになっています。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=_form.html.erb"></script>


ここまでの知識から、`app/views/posts/index.html.erb`に`render 'form'`という1行を追加してやれば一覧ページに投稿フォームを追加できるのではないかと予想できます。やってみましょう。一番上に追加します。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=index.html.erb"></script>

これでブラウザをリロードしてみると...

<div class="center400 article_image_box"><a href="//img2.allabout.co.jp/gm/article/b/441740/err.png" class="slide_image" rel="allabout-gallery" title="err"><img src="//img2.allabout.co.jp/gm/article/441740/err.png" width="366" height="300" alt="err" class="article_image" /></a> </div>

エラーになってしまいました。`@post`というインスタンス変数がないと言っているので、[次のページ](/gm/gc/441740/2/)でViewのひとつ前、Controllerの該当する処理を見てみましょう。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>

まずは「Controllerで定義したインスタンス変数はそのままViewの中で使える」という結び付きを覚えておいてください。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=posts_controller1.rb"></script>

最初にformがレンダリングされていた`new`アクションでは、`Post.new`を`@post`に格納しているようです。同じことをindexアクションの中でもやらせてみましょう。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=posts_controller2.rb"></script>

<div class="center150 article_image_box"><img src="//img2.allabout.co.jp/gm/article/441740/in.png" width="150" height="163" alt="in" class="article_image" /></div>

うまくいきました。何か内容を入れて"Create Post"をクリックしてみると、詳細ページ(show)に移動します。この画面遷移も省いてしまいたいので、さらにControllerに手を入れます。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=posts_controller3.rb"></script>

`posts_path`は一覧ページ(index)のパスを生成しますので、投稿が成功すれば一覧ページ(= 今開いている画面)へリダイレクトするべし、という指定になります。
`config/routes.rb`の定義により生成されたルーティングは`bundle exec rake routes`コマンドで確認できます（[前回の記事](http://allabout.co.jp/gm/gc/440949/)参照）。ちなみに`*_url`と`*_path`の違いはドメインを含むかどうかです。`*_url`の方は環境に応じたドメインを含みますが、`*_path`は含みません。

不要になったviewファイルやルーティングを整理しておきましょう。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=rm.sh"></script>

`config/routes.rb`ファイルを編集します。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=routes.rb"></script>

`resources :posts`とすると、自動的に`index, new, show, edit, create, update, destroy`という一連のRESTfulなアクションが定義されます。さきほどnewアクションを削除したので、ルーティングファイルで`except: [:new]`という記述を追加してやります。

ここまでで「画面遷移せずに投稿」が実現できました。[次のページ](/gm/gc/441740/3/)では画面の要素を加減したり、表示するデータを変更する方法を学びます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### 投稿の新しい順に並べる

現在は投稿された順に、新しいものが下に来るように並んでいます。これを本家Twitterのように、新しいものが上に来る順序に並び替えてみましょう。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=order.rb"></script>

これだけで新しいものが上に来るようになります。並び順がわかりやすいように投稿時間を表示し、投稿時間を詳細ページへのリンクにします。さらにEditリンクを削除して一度公開した投稿は後から編集はできないように変更しました。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=index2.haml.erb"></script>

画面表示を確認してみます。

<div class="center200 article_image_box"><a href="//img2.allabout.co.jp/gm/article/b/441740/li.png" class="slide_image" rel="allabout-gallery" title="list"><img src="//img2.allabout.co.jp/gm/article/441740/li.png" width="183" height="150" alt="list" class="article_image" /></a></div>

なお、ここで使った`order`メソッドはActiveRecordの提供するものです。Rails consoleを起動し、`to_sql`メソッドを使ってどんなSQLが生成されるのか確認することが出来ます。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=to_sql.rb"></script>

このように、RailsのORM(Object Relational Mapper)であるActiveRecordは、SQLを直接書く代わりに可読性の高いメソッドを使って記述することが出来ます。より詳しい解説は [Railsガイド](http://guides.rubyonrails.org/active_record_querying.html) にあります。

ActiveRecordに頼りすぎてSQLを忘れてしまったり、普通に書くとすぐ出来るのにActiveRecordで実現する書き方を調べて時間を浪費してしまうと本末転倒ですが、用法用量を守って使う分にはとても便利です。


[次のページ](/gm/gc/441740/4/)ではCSSと画像で少し見た目を整えます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


いままではScaffoldの仮デザインをずっと使ってきましたが、最後にデザインをちょっと改良してみようと思います。

### assets -- Railsデザインの周辺技術

CSS, JavaScript, および画像といった静的ファイルは"assets"と総称され、`app/assets`以下に配置されます。旧バージョンのRailsではこれらの静的ファイルを`public`ディレクトリ以下に置いていましたが、[Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)機能を取り込んだバージョンから`app/assets`に置く方針に変更されました。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=assets.sh"></script>

ここで拡張子がcss, jsではないことに気がつくと思います。RailsはCSSではなく[SCSS](http://sass-lang.com/guide)を、JavaScriptではなくCoffeeScriptをそれぞれ標準で採用しているためです。SCSSの文法はCSSの拡張になっているため学習コストは低く、もし初めて見るのであればこの機会に使えるようになっておくとお得だと思います。CoffeeScriptはPythonやRubyのような文法を持ち、JavaScriptにコンパイルされる言語です。

今回編集するのはscssだけですが、RailsアプリケーションのUIをいじる場合はこの`app/assets`以下を触っていくことになると思います。


### デザインを調整する

本記事のメインテーマはあくまでRailsなのでデザインの方法論について踏み込みませんが、お手軽に「それっぽく」見せるために背景に風景画像を置き、半透明ボックスを重ねるという方法を取ります。加えて全体的に色を薄めにし、緑をテーマカラーとして揃えることを意識しました。

適当な写真を [写真素材 足成【フリーフォト、無料写真素材サイト】](http://www.ashinari.com/) などから探して来て、ファイル名を`background.jpg`にリネームして`app/assets/images`以下に移動します。ちなみに今回選んだのは [写真素材 足成：森のせせらぎ](http://www.ashinari.com/2013/11/26-384007.php)です。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=mvbg.sh"></script>

`app/assets/stylesheets/application.css` と `app/assets/stylesheets/posts.css.scss` 、そして `app/views/posts/index.html.erb`を、それぞれ次のように編集します。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=application.css"></script>

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=posts.css.scss"></script>

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=index3.html.erb"></script>


scaffoldで生成されたスタイルシートは不要なので削除します。

<script src="https://gist.github.com/memerelics/c71d507225fbdb84e0de.js?file=rmsc.sh"></script>

最終的に次のようになりました。

<div class="center400 article_image_box"><a href="//img2.allabout.co.jp/gm/article/b/441740/res.png" class="slide_image" rel="allabout-gallery" title="res"><img src="//img2.allabout.co.jp/gm/article/441740/res.png" width="321" height="300" alt="res" class="article_image" /></a> </div>

以上で今回の記事は終わりです。Viewまわりを中心に、UIを調整していく手順を学びました。次回はモデルの関連等を扱う予定です。
