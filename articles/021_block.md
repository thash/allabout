本記事ではRubyにおけるブロック、ブロック付きメソッドの定義、そしてブロックをオブジェクトとして扱うことのできるProcとlambdaを紹介します。


### ブロックとイテレータ

ブロックとは、単純に言えば「コードのかたまり」です。Rubyにおいては `do ... end` で囲われたところがブロックとなります。簡単な例を見てみましょう。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=times.rb"></script>

`do puts 'hoge' end` の箇所が「ブロック」と呼ばれます。ちなみに以下のようにブロックだけで存在することは出来ません。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=do.rb"></script>

このブロックに対してイテレータで操作を指定します。最初の例で言うと`times`がイテレータで、ブロック内のコードを"10回繰り返す"(10 times do something)ように指示しています。10回「`puts 'hoge'`」と書く代わりに共通部分をブロックに押しこめ、それをイテレータで好きなように操作している、という構図です。

イテレータ(iterator: 反復子)という呼び名はRubyにおいてはややミスマッチであり、「ブロック付きメソッド」「ブロックが渡されることを想定したメソッド」とでも表現したほうが正確かもしれません。ともかく、イテレータはブロックを引数に取ります。

イテレータによっては、ブロックに外から変数を渡すことができます。次はeachイテレータの例です。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=each.rb"></script>

ブロック内のコードには`n`という変数が含まれているため、nを知ることで実行されるコードが決定されます。ブロック引数は`|n|`というように、`|`で囲うことで表現できます。


### do...endと波括弧の違い

なお、`do ... end`の代わりに`{ ... }`と波括弧で書いてもほぼ同じ意味になります。唯一の差異は実行の優先順位で、例えば`do...end`を引数のカッコ省略と組み合わせた場合などに、ブロックとイテレータがまとめて認識されず、ブロックが無視されるような挙動をするため注意が必要です。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=parentheses.rb"></script>


[次のページ](/gm/gc/447885/2/)ではブロックを引数に取るメソッドを独自に定義する方法、その際の構文や決まり事について解説します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### ブロック付きメソッドを定義する

[前のページ](/gm/gc/447885/1/)では `each` や `times` といった標準のイテレータにブロックを渡して来ましたが、次はブロックを引数に取るメソッドを独自に定義してみましょう。

方法は簡単で、メソッド定義時に `yield` というキーワードを含めるだけです。yieldの箇所で渡したブロックが実行され、さらにyieldの使用回数に制限はありません。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=yield.rb"></script>

非情に単純です。

ちなみに例の最後で示したように、ブロックが渡されない場合はyieldの部分で`no block given (yield) (LocalJumpError)`が発生します。これを避けるために `Kernel.#block_given?` を使い、ブロックが渡されたときはyieldを実行するが、ブロックが渡されないときは別の動作をする(例えば任意の例外を投げる)ようなメソッドを定義できます。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=block_given.rb"></script>

さらに進み、`each` などでお馴染みのブロック引数がある場合を見てみます。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=yield_with_args.rb"></script>

「通常の引数」と「ブロック引数」が共存する場合は次のように書きます。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=yield_with_args2.rb"></script>



### ブロックをオブジェクトとして扱う

さてここまで、ブロックは「引数なのにメソッド定義の引数リストには現れない」「yieldという特別なキーワードで実行される」など、ある意味「特別扱い」をされてきました。

次に「ブロックをオブジェクトとして扱うことができれば、より柔軟なコードが書けるのではないか」と考えを進めてみます。たとえば渡されたブロックをその場でyield実行する以外に、別のメソッドに渡して処理をたらい回しにしたり、などという使い方が想定できます。

実際、それは可能です。先に上げた `iter` をもとに例を示します。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=ampersand.rb"></script>

iterの定義時に`&b`という「`&`」付きの特殊な引数を書いておきます。bの素性を調べてみると、Procというクラスのインスタンスであることがわかります。これが、ブロックを表現するオブジェクトの正体です。

> ブロックをコンテキスト(ローカル変数のスコープやスタックフレーム)とともにオブジェクト化した手続きオブジェクトです。
>
> [class Proc | Ruby 2.1.0 リファレンスマニュアル](http://docs.ruby-lang.org/ja/2.1.0/class/Proc.html)

Procインスタンスに対し`Proc#call`メソッドを呼び出すことでコードを実行させます。

また、Procインスタンスはブロック付きメソッドの引数で実体化させる以外に、他のクラスと同じく`Proc.new`するか、`Proc.new`と同じ意味の`Kernel.#proc`を使うことでも作成できます。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=proc.rb"></script>


[次のページ](/gm/gc/447885/3/)では`Proc.new`と同じくProcインスタンスを生成する「`lambda`」を紹介し、Procとの差異について解説します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### lambda

`Kernel.#lambda`もProcクラスのインスタンスを生成するメソッドです(lambdaはラムダと読みます)。生成されるオブジェクトはProcクラスのインスタンスですが、Procで作られたのかlambdaで作られたのかを区別するために`Proc#lambda?`というメソッドが用意されています。

Ruby 1.9からは"lambda"の代わりに `->` という書き方(アロー記法)も使えるようになりました。アロー記法の場合は引数が `-> {|x| ... }` ではなく `-> (x) { ... }` となることに注意してください。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=lambda.rb"></script>


### Procとlambdaの違い

Procとlambdaにはいくつかの違いがあり、おおまかに言うとlambdaの生成する手続きオブジェクトの方が、Procの生成する手続きオブジェクトに比べてメソッドに近い挙動をします。

1. 引数の数に厳密なのがlambda、寛容なのがProc
2. returnで自分自身から出るのがlambda、自分自身より上のメソッドをreturnするのがProc

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=arity.rb"></script>

lambdaの場合は引数の数(arity)が異なるとエラーになりますが、Procは足りない分をnilで埋め、余分な引数を捨てたうえで実行しています。

次にreturnの挙動です。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=return.rb"></script>

lambda内でreturnすると単にlambdaから出るだけで処理は続いており、Proc内でreturnしたときは`wrap_proc`自体からもreturnされそこで処理が終わっていることがわかります。


### クロージャ

最後にRubyから少し視野を広げて、計算機科学一般における「クロージャ」という概念でRubyのブロック、Proc、lambdaを眺めてみることにします。

[クロージャ（closure）](http://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AD%E3%83%BC%E3%82%B8%E3%83%A3) とは定義時のスコープにおける環境を保持し、その環境内でコードを実行することが出来るものです。なおここで言う「環境」とは「変数と変数の指すオブジェクトの集合」を指します。

Rubyにおいてクロージャと呼ぶことが出来るものは以下の3つです。

* ブロック
* Proc
* lambda

次のコード片は、ブロック、Proc、lambdaそれぞれの定義時に存在するローカル変数 「`x`」 をスコープの内側から参照する単純な例です。

<script src="https://gist.github.com/memerelics/f5b8c4de506e2674fcdd.js?file=closure.rb"></script>

※メソッドは定義時の環境を参照できないためクロージャには含まれません。


### 以上

以上、Rubyを特徴付ける「ブロック」周辺について解説を行いました。

今回に限らず、本連載ではなるべく正確な情報を掲載するよう心掛けています。記事内容に誤りを発見された場合は著者に連絡頂くか、 [allabout/021_block.md at master · memerelics/allabout](https://github.com/memerelics/allabout/blob/master/articles/021_block.md) からプルリクエストを送って頂ければ反映いたします。
