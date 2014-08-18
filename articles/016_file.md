### はじめに

今回は初学者を対象に、Rubyでファイルを開いて読み込む/書き込む方法、ディレクトリの扱いなどを説明します。


### open でファイルを開く

最もシンプルな使い方は`Kernel#open`メソッドでファイルを開くことです。openはFileクラスのインスタンスを返します。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=open.rb"></script>

FileはIOクラスを祖先に持ち、ファイル操作は基本的にIOクラスのインスタンスメソッドを使って行います。またEnumerableモジュールもインクルードされているため、each, map, reduceなどが利用可能です。以下に実例を見ていきます。

行ごとの処理を行うには`IO#each_line`を使うのが簡単です(`IO#each`も同じ機能を持つ別名メソッドです)。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=rl.rb"></script>

openしたファイルは、必ずcloseする必要があります。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=close.rb"></script>

また、openにブロックを渡す方法もあります。こうすればファイルオブジェクトはブロック終了時にcloseされるため、close忘れがありません。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=bl.rb"></script>


### ファイルに書き込む

ファイルへの書き込みは、オープンしたFileインスタンスに対して`IO#puts`メソッドを使って行います。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=er.rb"></script>

エラーが発生してしまいました。「IOError: not opened for writing」と言われている通り、openするときに書き込み可能な形式で開いてやる必要があるのです。これを「モード」と言い、おおまかに以下のような種類があります([module function Kernel.#open](http://docs.ruby-lang.org/ja/2.1.0/method/Kernel/m/open.html)より)。


* r
  * ファイルを読み込みモードでオープンします。デフォルトはこのモードになっているため、先程は書き込みが失敗していました。
* w
  * ファイルを書き込みモードでオープンします。オープン時にファイルがすでに存在していれば その内容を空にします。
* a
  * ファイルを書き込みモードでオープンします。出力は常にファイルの末尾に追加されます。
* r+
  * 読み書き両用モード。ファイルの読み書き位置は先頭にセットされます。
* w+
  * 読み書き両用モード。ファイルの読み書き位置は先頭にセットされ、オープン時にファイルがすでに存在していればその内容を空にします。
* a+
  * 読み書き両用モード。書き込みは常にファイル末尾に行われます。


それでは、先ほどのファイルを末尾に追加する`a+`モードで開いて、内容を追加してみます。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=add.rb"></script>


[次のページ](/gm/gc/445639/2/)ではディレクトリを扱う方法や、その他のよく利用するメソッドなどを紹介します。


### ディレクトリ

ディレクトリの作成と削除はそれぞれ`Dir.mkdir`、`Dir.rmdir`メソッドにより行います。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=add.rb"></script>

また、`Dir.getwd`によるカレントディレクトリの取得、

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=getwd.rb"></script>

`Dir.glob`によるディレクトリ以下のファイル一覧取得などもよく使うメソッドです。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=glob.rb"></script>


### その他のメソッド

`File.exist?`: 指定されたファイルが存在するか否かの真偽値を返します。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=exist.rb"></script>

`File.ftype`: 名前を指定すると、ディレクトリ、ファイル、シンボリックリンク、ソケットなど、どの種類のファイルであるかを返します。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=ftype.rb"></script>

`File.dirname`, `File.basename`, `File.extname`: それぞれファイルのディレクトリ名、ディレクトリを除いたファイル名、ファイルの拡張子を文字列で返します。

<script src="https://gist.github.com/memerelics/74492652734544f1f8df.js?file=names.rb"></script>

