今回の記事ではRubyにおける演算子(operator)に着目し、演算子の種類、優先順位という概念、そして演算子を定義する方法について解説します。


### Rubyにおける演算子と優先順位


[Ruby 2.2.0 リファレンスマニュアル > 演算子式](http://docs.ruby-lang.org/ja/2.2.0/doc/spec=2foperator.html)

Rubyはモダンな言語に期待される大抵の演算子を備えています。たとえば算術における加減乗除（`+, -, *, /`）や法（`%`）・べき乗（`**`）、比較演算子（`>, <, <=, >=, <=>`）、論理演算子（`&&, ||, !, and, or, not`）、バイナリ演算子（`&, |, ^, ~`）などです。

以下に一覧を示します。演算子には優先順位が存在し(後述)、上にあるほど優先順位が高くなっています。

<a title="t" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/454015/ta2.png"><img height="400" width="257" class="article_image" alt="t" src="//img2.allabout.co.jp/gm/article/454015/ta2.png" /></a>

出典: 『パーフェクトRuby』p.73

<div name="Item:0003:4774158798" class="ItemCassette">パーフェクトRuby (PERFECT SERIES 6)</div>


### 優先順位の実例

演算子の優先順位とは、代数学の四則演算で「×と÷は、+と-よりも先に計算する」というルールによって `1 + 2 * 3` が `1 + (2 * 3)` と解釈されていたように、並べて書いた時どちらの演算を先に行うか、あらかじめ定義しておくものです。

<script src="https://gist.github.com/memerelics/b59cbbe6bf0187f2b3b9.js?file=pr.rb"></script>

カッコを付け計算順を明示することで、優先順位とは別の順番で計算させることができるのもすんなり納得できる話だと思います。


一点、`and`と`or`について補足しておきます。これらの演算子は、以下のようにそれぞれ`&&`、`||`と同じく論理AND、論理ORに相当します。

<script src="https://gist.github.com/memerelics/b59cbbe6bf0187f2b3b9.js?file=and.rb"></script>

`and`と`or`は可読性が高くてよさそうに見えるのですが、先に上げた表からわかる通り優先順位が低く、代入式やメソッド呼び出しと同じ行に書いたときの挙動が直感的に掴みづらいため個人的に利用をおすすめしません。例えば以下の様な例が考えられます。

<script src="https://gist.github.com/memerelics/b59cbbe6bf0187f2b3b9.js?file=par.rb"></script>

`&&`と`and`で結果が異なっています。これは、`and`よりも代入演算子（`=`）の優先度が高いため、`and`の評価よりも先にboolにTが代入されてしまうためです。

<script src="https://gist.github.com/memerelics/b59cbbe6bf0187f2b3b9.js?file=par_desc.rb"></script>

他人のつもりで読んでみて瞬時に処理順序がわからないコードは、`()` を使って優先順位を明示してやるか、複数式に分割するほうが良いと思います。


[次のページ](/gm/gc/454015/2/)では、メソッドとして定義されている演算子と、それらの再定義について解説します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### 演算子とメソッド

Rubyの演算子の中には、本体の処理はメソッドとして定義されており演算子としての姿は糖衣構文に過ぎないものがいくつか存在します。以下に再掲した演算子表のうち赤いドットを打っている演算子がメソッドです。

<a title="t" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/454015/ta2.png"><img height="400" width="257" class="article_image" alt="t" src="//img2.allabout.co.jp/gm/article/454015/ta2.png" /></a>

出典: 前出『パーフェクトRuby』p.73

たとえばメソッドとして定義されている演算子の一例として比較演算子「`<`」に着目してみます。

<script src="https://gist.github.com/memerelics/b59cbbe6bf0187f2b3b9.js?file=lt.rb"></script>

2番目の書き方でも動くことから、`1 < 2` という書き方は「レシーバ1に対して、引数2をとってメソッド`<`を呼び出す」処理にほかならないことがわかります。


### 演算子の再定義

演算子もメソッドであるということは、そのメソッド表現さえ特定してしまえば好きなように再定義することが出来ます。

本記事では例として「`==`」演算子(メソッド)を再定義して、通常と異なる動きをさせてみます。まず普通にオブジェクト同士を`==`で比較すると何が起こるかを見てみましょう。

<script src="https://gist.github.com/memerelics/b59cbbe6bf0187f2b3b9.js?file=redef.rb"></script>

何も継承せずクラスを定義した時、その親クラスは `Object, Kernel, BasicObject` となります。一番プリミティブな`==`が定義されているのはBasicObjectクラスで、ドキュメントによればその定義は次の通りです。

> Equality---At the Object level, `==` returns true only if obj and other are the same object.
>
> [Class: BasicObject (Ruby 2.2.0)](http://ruby-doc.org/core-2.2.0/BasicObject.html)

つまり `==` は左右が同じオブジェクトの時のみtrueを返します。上記のGreetingインスタンスはまさにこの通りの挙動を示しています。

さて次に、Greetingクラス特有の`==`メソッドを定義してみましょう。元気よく（最後に`!`をつけて）挨拶していれば等しい挨拶とみなすことにします。

<script src="https://gist.github.com/memerelics/b59cbbe6bf0187f2b3b9.js?file=redef_greet.rb"></script>

演算子`==`の結果が変わったことが確認できます。

このような実装は特殊な用例に見えるかもしれませんが、表から見えづらいだけで、実際のところいろいろな場所で使われています。たとえば「`===`」メソッドは各クラス・モジュールで再定義され、case文の表現力向上に一役買っています。参考: [Rubyのcase式と===演算子について - しばそんノート](http://d.hatena.ne.jp/shibason/20090617/1245231492)。


### 以上

以上でRubyの演算子についての記事は終わりです。演算子の一部がメソッドとして実装されていることで柔軟な拡張を可能としているんだな、となんとなく実感できれば幸いです。Rubyの設計は潜ってみると「あれ、見た目は違うけどこの設計思想は別の場所でも聞いたな」ということが多々あり、他の例も探ってみると面白いかもしれません。
