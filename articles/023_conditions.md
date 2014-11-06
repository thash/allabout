### 条件分岐・制御構文

今回の記事ではRubyの基本的な条件分岐と制御構文について解説し、Rubyのifやcaseが値を返す「式」であることについても触れます。


### if、unless

Rubyの `if` はおおむね特別な知識を必要としない構文ではないかと思います。`if` 条件式のカッコやその後のthenは省略可能です

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=if.rb"></script>

一点、「`else if`」でも「`elseif`」でもなく「`elsif`」である事に注意してください。他の言語も一緒に書いてると混乱しがちです。


また、`unless` は条件式が偽であれば実行される構文で、主としてコードの可読性を上げるためにifの代わりに使われます。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=unless.rb"></script>

`unless` 使用ケースの目安として、経験上「◯◯でなければ実行」と頭のなかでシンプル読める場合にのみ使うべきであり、

1. `else` 句が登場するとき
2. 複数の条件が利用されるとき

には、`unless` を使わない方が無難ではないかと思います。



### Rubyの真偽

ここでやや横道にそれ、Rubyにおける真偽値の扱いをおさらいしておきます。

「`false`と`nil`のみが偽、それ以外は真」

です。0や空文字列も真なので注意してください。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=bool.rb"></script>


[次のページ](/gm/gc/448655/2/)では後置条件式、三項演算子を紹介します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>



### 後置条件式

「`if` の中身が1行しかないのに、わざわざif、本体、endと3行も使ってしまうのが気持ち悪い...」と設計者が考えたのかどうかは定かではありませんが、Rubyでは`if` や `unless` を1行に収めて書くことができます。

例えば、帰宅したあと疲れてなければジョギングして、成人していればビールを飲んでから寝る、というコードは次のように書けます。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=single_line.rb"></script>

条件式と処理内容がともに単純なコードであれば、すっきりと読みやすくなります。



### 三項演算子

Rubyの三項演算子を使うと、 `if <cond> then <true_clause> else <false_clause> end` のif文を `<cond> ? <true_clause> : <false_clause>` と書くことができます。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=ternary.rb"></script>

もし `elsif` を含むif式を三項演算子にしようとすると、次のようにネストさせる必要があります。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=ternary_nest.rb"></script>

しかしここまで来ると逆に可読性が悪くなってしまいます。条件分岐がネストするときは素直にifか後述のcaseを使ったほうが無難です。


[次のページ](/gm/gc/448655/3/)ではcase式を紹介し、最後にifやcaseが「値を返す」ことに触れます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### 値を返す条件式

ここまで触れてきませんでしたが、いままで紹介してきた構文はすべて「式」であり、値を返します。この特性は非常に便利で、たとえば一例として本番環境・ステージング環境・開発環境でアクセスするAPIのURLを切り替えるときを考えてみます。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=retval.rb"></script>

例のように、if式の返す値を変数に代入してやれば変数代入が一箇所にまとめることができます。

三項演算子のところで取り上げた例はそれぞれの節内でputsしていましたが、三項演算子自体が値(この例だと文字列)を返すため以下のようにも書けます。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=retval_ternary.rb"></script>



### case

`case` は可能性を並列に並べるときに使います。`case` は言語によっては `switch` や `cond` という名前で似た機能が提供されていることもあります。

また、caseもif式や三項演算子のように値を返します。例として上記の環境によるURL切替処理をcaseを使って書き換えてみましょう。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=case.rb"></script>

さて、上の例では単純に「`==`」による文字列比較と同じ動作をしていますが、when部分では内部的に 「`===`」演算子による等価評価が行われているため、より柔軟なマッチをサポートしています。

「`===`」はデフォルトでは内部的に「`==`」を呼び出すだけですが、いくつかのクラス(Range, Moduleなど)で再定義されているため、たとえばオブジェクトのクラスによって処理を分岐させたり、

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=clz.rb"></script>

whenのあとにRangeクラスのオブジェクトを置いて、含まれる範囲で処理を分けることも出来ます（ifで大小の不等号を並べるよりも読みやすいのではないかと思います）。

<script src="https://gist.github.com/memerelics/9d7b7468c4b257b4b852.js?file=range.rb"></script>


詳しくは`Object#===`のリファレンス（[class Object](http://docs.ruby-lang.org/ja/2.1.0/class/Object.html#I_--3D--3D--3D)）を参考にしてください。
