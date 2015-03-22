軽い書き捨てスクリプトを除けば、Rubyコードは複数ファイルにまたがることが普通です。別のファイルに書かれたコードを読み込むために、いくつかメソッドが用意されています。それらの使い方を比較して行きます。


### require

最も基本的なメソッドは`require`です。ロードしたいファイルまでのパスを記載します。拡張子の「.rb」は省略可能です。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=require.sh"></script>


ディレクトリ内に`require_a.rb`と`require_b.rb`というファイルがあるとして、aからbを読み込んでみます。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=require_a.rb"></script>


例にある通り、同じディレクトリにあるファイルであってもファイル名を書くだけではロードすることが出来ず、カレントディレクトリ「.」を付ける必要があります。


### require relative

`require_relative`は「そのファイルが置かれているディレクトリ」からの相対パスで記載されたファイルを解釈できます。例えば、以下の様なディレクトリ構成でファイルが置かれているとき、

<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=relative.sh"></script>

`abc/foo.rb` の中から `abc/def/bar.rb` をロードするには次のようにします。

<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=foo.rb"></script>

Rubyでは実行中ファイルまでの絶対パスを`__FILE__`で取得できるので、例にあるように`File.expand_path`と`File.dirname`を組み合わせて`require_relative`と同じく相対パスでのロードをさせることもできます。


[次のページ](/gm/gc/453214/2/)では、ロードパス(`LOAD_PATH`)の概念について解説します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### LOADPATH

たとえば`require 'prime'`とすると、素数に関連するメソッドが利用可能となります。これは前ページの議論に則れば`prime.rb`というファイルがどこかにあるはずです。先ほどのrequireの説明では触れませんでしたが、そもそもrequireは「どこを基準に」ファイルへのパスを見つけるのでしょうか。

答えは `$LOAD_PATH` というグローバル変数です。`$:`という別の名前もあります。ここにはrequireで基準となるディレクトリが配列の形で入っていることがわかります。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=load_path.rb"></script>


上の疑問に答えるために、`$LOAD_PATH`以下に`prime.rb`というファイルを探してみると、実際に存在することがわかります。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=load_path2.rb"></script>

また、コード中で`$LOAD_PATH`にパスを追加することで、requireの基準ディレクトリを変更することも可能です。


[最後のページ](/gm/gc/453214/3/)では、`Kernel#load`および`Kernel#autoload`メソッドを取り上げます。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### loadとrequireの違い

loadもrequireと同じく別ファイルにあるRubyコードを読み込む機能を持ちますが、以下の様な違いがあります。


* requireは与えられたファイル名に「.rb」「.so」を自動付与して検索するが、loadはしない
* requireは一度読み込んだファイルを再度読み込もうとするとスキップするが、loadは何度でも読む


簡単な例を示します。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=load.sh"></script>


`load.rb`というファイルから`loaded.rb`をロードするとします。次のようにrequireを使った場合は、二度目の呼び出しでfalseが返ってスキップされます。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=require_load.rb"></script>


しかしloadを使うと、`loaded.rb`ファイルが二度評価され、定数`XYZ`が二度初期化されているという警告が表示されます。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=load.rb"></script>


コードを修正しながらirb(もしくはpry)などのREPL中から何度も読みなおして動作テストをするケースなどでは、loadの方が使い勝手が良いことがあります。


### autoload

最後にautoloadです。利用ケースの一例としては、レスポンスが重視される巨大なアプリケーションが挙げられます。巨大なアプリケーションでは、初期化時にすべてをロードするのではなく必要になった時に読み込むという遅延ロードを活用したほうがパフォーマンスがよくなることがあります。autoloadはこのようなときに利用される機能です。

Rubyリファレンスにわかりやすい説明があるので引用します。


> autoloadメソッドを使うと、ネストされたクラスやモジュールが必要になったときにRubyファイルを自動的に読み込む（requireする）ことができます。引数nameには定数名（クラス・モジュール名）をシンボルか文字列で指定し、引数file_nameにはファイル名を指定します。戻り値はnilです。
>
> [autoload (Module) - Rubyリファレンス](http://ref.xaio.jp/ruby/classes/module/autoload)


以下、使い方を示します。

次のような`Shell::Core`クラスを想定します。このファイルが読まれた時に1行目に書いてある「`puts 'loading core.rb'`」が出力されるようにしています。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=core.rb"></script>


これを、Shellクラスからautoloadしてみます。


<script src="https://gist.github.com/memerelics/df8913fac159645a9b7e.js?file=autoload.rb"></script>


autoloadを呼んだ時点では`loading core.rb`と出力されず、実際に`Shell::Core`インスタンスが必要とされた時にはじめてロードされていることがわかります。


### まとめ

以上、一見わかりづらい読み込み系メソッドの違いを簡単に見てきました。最も原始的なのがload、二重読み込み防止などで使い勝手がよく使われるのがrequire、相対パスで簡単にrequireできるようにしたのが`require_relative`、そしてautoloadはクラス・モジュールの遅延ロードを実現するものでした。
