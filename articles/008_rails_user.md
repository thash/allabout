### アプリケーションにユーザ情報を加える

前回の記事 [RailsでTwitterクローンを作る(2) -- 画面レイアウトを整える [Ruby] All About](http://allabout.co.jp/gm/gc/441740/) では、レイアウトや画面遷移に変更を加える方法を解説しました。

今回は新たにUserモデルを作成して、sorceryを使ってアプリケーションにユーザ認証を追加する方法、モデル同士の関連(association)を定義する方法、マイグレーション(migration)機能でDBスキーマに変更を加える方法などを学びます。


### sorcery gemを導入、ユーザモデルを作成

[sorcery](https://github.com/NoamB/sorcery)はRailsにシンプルなユーザ認証認証を提供するgemです。Gemfileに

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=gem.rb"></script>

を1行追加して`bundle install`でインストールされます。その後`bundle exec rails generate sorcery:install`を実行すると、以下のように標準テンプレートが作成されます。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=install.sh"></script>

migrateファイル`db/migrate/20140423163942_sorcery_core.rb`の中を見てみると、email、暗号化パスワード、saltが定義されています。なお、Saltについては [Saltってなに? -- いまさら聞けないパスワードの取り扱い方](http://www.slideshare.net/ockeghem/ss-25447896/23) などを参考にしてください。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=sorcery_core.rb"></script>

マイグレーションを実行してDBにusersテーブルを作成します。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=migrate.sh"></script>

また、作成された`User`モデルのコード(`app/models/user.rb`)を覗いてみると、`ActiveRecord::Base`を継承した標準的なモデルに、`authenticates_with_sorcery!`の1行が加えられているのがわかります。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=models_user.rb"></script>


さらに、画面に表示する時に「ユーザ名(name)」と「アイコン画像(icon)」があると見栄えがしそうなので、追加しておきます。以下のようにして`rails generate migration`コマンドでマイグレーションファイルを作成します。`g`はgenerateサブコマンドの省略形です。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=new_migration.sh"></script>

`AddNameAndIconToUsers`としましたが、名前は動作に関係しないため、後で見返して判別の付く名前であればなんでも良いです。こうして生成された`db/migrate/20140425171430_add_name_and_icon_to_users.rb`の`def change`メソッド中に`add_column`の2行を追加して、

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=add_name_and_icon_to_users.rb"></script>

再び`rake db:migrate`を実行すると、最終的にusersテーブルは次のようなスキーマとなります。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=users.sql"></script>


[次のページ](/gm/gc/441762/2/)では新規ユーザの登録処理を作成します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### ユーザ登録処理の実装

簡単なユーザ登録・ログイン機能を実装します。まずは[前回](http://allabout.co.jp/gm/gc/441740/)の内容を思い出し、Controllerを作成、

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=gene_con.sh"></script>

`rake routes`で確認しながらroutingを記述します。今回はユーザ登録ページ(new)とユーザ作成(create)、ログインとログアウト処理を受け付けるようにします。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=routes.rb"></script>

`login`と`logout`にするとsorceryの提供するメソッドと名前がかぶってしまうので`sigin`, `signout`にしています。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=routes.sh"></script>

`collection`ブロック以下に書いたルーティングは、`/users/...`直下に定義されます。対応する概念は`member`で、`collection`を`member`に置き換えると「`signin_user POST   /users/:id/signin(.:format)  users#signin`」というようなルーティングが生成されます。
Railsのルーティングは慣れるまで思ったように行かないものだと思いますが、詳しくは [Rails Routing from the Outside In — Ruby on Rails Guides](http://guides.rubyonrails.org/routing.html) などを参照してください。


ユーザ作成処理から作っていきます。`/users/new`ページにフォームを作成し、submit先を`users_path`とします。すると先のルーティング定義からUsersControllerのcreateアクションに処理が流れてくるので、その中でユーザモデルを作成すると、以下のようなコードが出来上がります。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=new.html.erb"></script>

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=users_controller.rb"></script>

注意する必要があるのは新規ユーザ作成時に`user_params`メソッドでパラメータを加工してから`User.new`している部分で、
[RailsでTwitterクローンを作る(1) -- Scaffoldでひな形を生成 [Ruby] All About](http://allabout.co.jp/gm/gc/440949/) では触れませんでしたが、scaffoldで作成された`app/controllers/posts_controller.rb`でも同じ処理が行われているので見返してみてください。

それでは、実際にformに入力してpostしてみます。

<div class="center200 article_image_box"><a href="//img2.allabout.co.jp/gm/article/b/441762/create.png" class="slide_image" rel="allabout-gallery" title="create"><img src="//img2.allabout.co.jp/gm/article/441762/create.png" width="185" height="150" alt="create" class="article_image" /></a></div>

なお`icon`カラムには画像のURLを入力する仕様にしていますが、これは少々不便です。今後の連載で手元のファイルを直接アップロードしてアイコン登録する機能を追加する予定です。

`rails console`でUserモデルを確認してみると、データが保存されたのが確認できます。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=user_first.rb"></script>

この際、sorceryの機能で保存時にパスワードが暗号化され、また同時にsaltが生成されているのがわかります。

[次のページ](/gm/gc/441762/3/)では、emailとpasswordを使ってログインする機能、ログイン状態に応じて表示や機能を分岐する方法を解説します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### ログイン・ログアウト機能の実装

まずはログインです。未ログインの時は`/users/signin`にemailとpasswordをPOSTするフォームを表示し、ログイン中の場合は現在のユーザの名前とアイコンを表示するようにします。アイコン表示には、`<img>`タグを生成するrailsのヘルパー`image_tag`を使います。同時に、レイアウトをサブカラムとメインカラムに分割してみます。
sorceryの提供する`logged_in?`と`current_user`を使用することで、比較的意味を汲み取りやすいコードが書けます。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=layout.erb"></script>

見た目は以下の通りです。完成形のCSSは[githubに上げているコード](https://github.com/memerelics/allabout/blob/article007/samples/Rwitter/app/assets/stylesheets/posts.css.scss)を見て下さい。

<div class="center200 article_image_box"><a href="//img2.allabout.co.jp/gm/article/b/441762/login.png" class="slide_image" rel="allabout-gallery" title="login"><img src="//img2.allabout.co.jp/gm/article/441762/login.png" width="200" height="93" alt="login" class="article_image" /></a></div>

さて、ルーティング定義で見たように、submitされた`/users/signin`処理を受け取るのは`UsersController#signin`アクションです。こちらは次のように実装します。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=signin.rb"></script>

ここで使っている`login`メソッドもsorceryの提供するもので、ログインが成功すれば`session[:user_id]`にidが格納されるというシンプルな作りです。ログイン後の画面は以下のようになります。

<div class="center200 article_image_box"><a href="//img2.allabout.co.jp/gm/article/b/441762/loggedin.png" class="slide_image" rel="allabout-gallery" title="loggedin"><img src="//img2.allabout.co.jp/gm/article/441762/loggedin.png" width="200" height="94" alt="loggedin" class="article_image" /></a></div>

同じように、sorceryの`logout`メソッドを使って`UsersController#signout`アクションにログアウト処理を実装します。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=signout.rb"></script>

viewの方は、サブカラムにログアウトリンクを追加しておきましょう。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=logout.erb"></script>

`link_to`ヘルパーに`method: :delete`オプションを追加することで、DELETEリクエストを送るリンクを生成できます。


ログイン・ログアウト処理が実装できたので、未ログイン状態での機能に制限をつけます。追加するロジックは

* [view] 未ログイン時はフォームを隠す
* [controlelr] ログイン時のみ投稿処理(`PostsController#create`)を許可する

のふたつです。

`app/views/posts/index.html.erb`に次のif文を追加し、

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=render_form.erb"></script>

`PostsController#create, destroy`の前にログイン状態をチェックするフィルター「`require_login`」を噛ませます。このメソッドもsorceryの提供するものです。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=require_login.rb"></script>


[次のページ](/gm/gc/441762/4/)では、投稿データに投稿したユーザの情報を紐付けて、誰が発言したのか区別できるように表示を改良します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### モデル同士を関連付ける

それではようやく、ログイン状態で投稿したデータをユーザと紐付けます。モデル同士を関連付けるためには、`Post`モデルが`user_id`というカラムを持ち、その中に投稿者のidが入っている必要があります。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=user_id.rb"></script>

migrationファイルを作成したらお馴染みの `bundle exec rake db:migrate` です。これでpostsテーブルに`user_id`カラムが追加されます。


DBの準備が済んだら、モデルに手を入れていきましょう。ActiveRecordの機能を使えばモデル同士の関連をシンプルに記述することが出来ます。UserモデルとPostモデルに次のコードを追加します。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=relations.rb"></script>

上記の記述により、あるユーザの投稿一覧が`User#posts`で取得でき、ある投稿の投稿者が`Post#user`で参照できるようになります。

`PostsController#post_params`で、ログイン中のユーザidをパラメータに追加します。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=post_params.rb"></script>

これで、投稿にユーザ情報を紐付けることができました。さらに投稿一覧にも発言者のアイコンを表示しましょう。`app/views/posts/index.html.erb`を次のように変更します。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=posts_with_users.erb"></script>

発言者のアイコンと名前を表示し、自分の発言のみ削除できるようにします。user_idのついていない今までのデータは一旦消してから、試してみましょう。

<script src="https://gist.github.com/memerelics/89e6ce0b83d8bda8a16f.js?file=delete_posts.sql"></script>

最終的に、次のような画面が出来上がりました。少しはTwitterっぽくなってきたでしょうか。

<div class="center200 article_image_box"><a href="//img2.allabout.co.jp/gm/article/b/441762/last.png" class="slide_image" rel="allabout-gallery" title="last"><img src="//img2.allabout.co.jp/gm/article/441762/last.png" width="200" height="101" alt="last" class="article_image" /></a></div>


### 機能追加のヒント

Rails入門の連載は今回で一旦終わりです。Railsに初めて触れる人に、なんとなくRails開発の雰囲気を掴んで頂けると嬉しいです。

応用編として、このTwitterもどきに「フォロー」や「お気に入り」、「RT(リツイート)」機能を付けてみると面白そうな気がします。今後の連載でも題材として使用するかもしれません。
