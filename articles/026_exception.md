### 例外とは何か

プログラムの実行は失敗する(エラーが発生する)ことがあります。たとえば開こうとしたファイルがない場合、メソッドに渡す引数の数が違った場合、数値を0で割ろうとした場合... などなど、そのレイヤーは様々です。

プログラムがエラーを発生させた時、何も対策をしないとその時点でプログラムはクラッシュし、実行は終了してしまいます。しかしあらかじめプログラマが「助け舟」を出しておくことで、プログラムの続行を可能にするのが「例外処理」です。

例外処理ではある程度「失敗」をパターン分けして「このパターンの失敗が起こったらこう対応する」と決めておくことで、異常が発生してもプログラムの実行を止めずに続行させることができます。


### 例外のクラス構造

オブジェクト指向言語たるRubyでは、例外もクラスシステムに組み込まれています。まずすべての例外の親となるのは [Exceptionクラス](http://docs.ruby-lang.org/ja/2.1.0/class/Exception.html) で、そこから派生した例外クラスがいろいろと定義されています。『パーフェクトRuby』p.84から引用した以下の図を参考にしてください。

<div class="center300 article_image_box"><a title="classes" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/450205/pr.png"><img height="366" width="300" class="article_image" alt="classes" src="//img2.allabout.co.jp/gm/article/450205/pr.png" /></a></div>

とりわけ大きなサブグループの`StandardError`が見つかると思います。アプリケーションを記述する際、独自の例外を定義する場合はこのStandardErrorを継承するのが基本です。

[次のページ](/gm/gc/450205/2/)では、例外を捕捉する方法と、例外を意図的に発生させる方法を説明します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### 例外を捕捉する(rescue)

たとえばDateオブジェクトをnewする時、存在しない日付を渡してやると `ArgumentError: invalid date` が発生します。ArgumentErrorは、`Exception`から見ると `Exception > StandardError > ArgumentError` という孫の位置に当たります。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=date.rb"></script>

Date.new時のこの例外を捕捉して「とりあえず失敗したら今日のDateオブジェクトを作成する」という方法で「助け舟」を出してやりましょう。助け舟をあらかじめ用意してやることを「例外を捕捉」すると言います。例外を捕捉するためには、エラーが発生する可能性のある領域を`begin ... end`で囲ってやり、例外が発生した場合の処理を `rescue` 以下に記述します。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=rescue.rb"></script>

`raise => e` とすることで、例外オブジェクトを`e`という変数に束縛しています。ログに例外の詳細を吐き出しつつ、とりあえずプログラムは`Date.today`の値を使って続行させることが出来ます。


rescueする際に例外クラスを指定することで、特定の例外のみ捕捉させることができます。また、rescue節は複数設置可能です。ここでrescue指定した例外クラスの「すべての子」も補足対象となることに注意してください。たとえば`rescue StandardError` とすれば、StandardErrorを継承しているIOErrorやRangeErrorなども捕捉対象となります。以下に例を示します。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=multi_rescue.rb"></script>

<br />

### 必ず実行させる(ensure)

begin内の実行が成功しようが失敗しようが、必ず実行させたいタイプの処理があります。たとえばbegin内でファイルをオープンしたので、処理を片付ける前に必ず閉じておきたい、というような場合です。

そういう場合はensure節を書いておくことで、begin内が成功した場合も、失敗してrescueに補足された場合も必ず実行されることが保証されます。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=ensure.rb"></script>

<br />

### 例外を発生させる(raise)

さて、ここまではRubyが発生させるエラーのみを扱って来ました。プログラム中で意図的に例外を発生させる場合、`Kernel#raise`メソッドを使います。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=raise.rb"></script>

引数にメッセージのみ指定する場合、RuntimeErrorが発生します。これは`Exception > StandardError > RuntimeError` というに位置する例外クラスです。raiseに引数として例外クラスを渡すことで、`RuntimeError` 以外の例外を発生させることができます。これは独自に定義した例外クラスでも構いません。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=original_exception.rb"></script>


[最後のページ](/gm/gc/450205/3/)では、いくつか例外処理の実例を示したいと思います。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### メソッド内のrescue

前ページまでは「`begin...end` 内のブロックで起こった例外を補足する」としてきましたが、メソッド定義内においてはその限りではありません。明示的に `begin...end` を指定しない場合、メソッドの`def ... end` が捕捉対象ブロックとみなされます。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=def.rb"></script>


### rescueした後に再度raiseしなおす

実用コードにおいては、rescueで例外を補足したものの、ある条件ではやはり例外を上げてプログラムを停止させるのが正しい(あるべき)処理である、というケースが考えられます。そのような処理は、rescue節の中で補足した例外オブジェクトを引数にしてもう一度raiseすることで実現されます。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=reraise.rb"></script>


### 後置rescue

実のところ、例外捕捉対象となるコードが1行の場合は、`begin...end` および rescue 節を書く必要すらなく、if文のように後置記法のrescueを使うことが出来ます。例を見たほうがわかりやすいので、以下のコードを見てください。

<script src="https://gist.github.com/memerelics/739a21fc8c8fbd7e8cd0.js?file=back_end_rescue.rb"></script>

`value`には本来`do_something` メソッドの返り値が入りますが、`do_something`内で例外が起こった場合は後置rescueにより補足され、valueにはnilが束縛されることとなります。


### 以上

以上がRubyの例外処理の基本です。例外処理に関しては言語の「決め」が大きいので、他の言語と比較することで理解が深まっていくのではないかと思います。
