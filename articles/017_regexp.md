### 正規表現とは

正規表現(Regular expression, regexpとも)は文字列のパターンを表現する方法です。Rubyでは正規表現はRegexpクラスに実装されています。`Regexp.new("AllAbout")`とすると正規表現オブジェクトが生成されますが、実際のコードでは`/`で挟むリテラルを使用することがほとんどです。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=new.rb"></script>

また、判定する文字列にスラッシュが含まれている場合はエスケープする必要がありますが、含まれるスラッシュの数が多くなってくると、代わりに`%r(...)`という書式を使った方が可読性が上がります。ちなみに`()`の他`{}`や`||`も使えます。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=lit.rb"></script>

ここで正規表現の細かな記法を説明することはしませんが、よくある使われ方をいくつか並べておきます。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=ex.rb"></script>

また、N回の繰り返しを指定するには、パターンの後ろに`{N}`と付けます。
たとえば`111-1234`のような郵便番号を抜き出す正規表現は以下のように書けます。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=n.rb"></script>

N回以上M回以下の繰り返しは`{N,M}`とカンマで区切ります。


[次のページ](/gm/gc/446050/2/)では、正規表現を使って文字列をマッチングしたときの挙動を解説します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### 正規表現の使い方

正規表現で表したパターンが文字列に含まれるかどうかは、`=~`演算子を使って判定します。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=to.rb"></script>

含まれる場合は、含まれる場所のインデックスが返り、含まれない場合はnilが返ります。Rubyは「falseとnil」のみが偽であり、それ以外は真値扱いなので、if文などの条件分岐に利用できます。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=if.rb"></script>

このとき、マッチした部分を参照するには`$&`を使います。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=if2.rb"></script>

マッチした部分を後から使うことを「後方参照」と呼びます。Rubyの後方参照は`$&`だけではなく、正規表現の中で`()`を使って部分に分けてやると、`$1, $2, ...`という変数で参照できるようになります。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=back.rb"></script>

パターンの決まった文字列から情報を抽出したいときに便利です。


[次のページ](/gm/gc/446050/3/)では、正規表現を使って文字列からパターンを抜き出したり、文字列自体を置換する方法を説明します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### 文字列からパターンを抜き出す

`String#scan`メソッドは、文字列から正規表現にマッチするパターンを取り出して配列を返します。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=scan.rb"></script>

なお`\w`は「単語」使用できる任意の1文字を表し、それに`+`を付けることで英単語だけをscanしています。


### 文字列をパターンで区切る

`String#split`を使うと、正規表現のパターンで文字列を分解して配列を返します。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=split.rb"></script>


### 文字列を置換する

`String#gsub`を使うと、文字列の中で正規表現にマッチしたパターンを別の文字列に置き換えることが出来ます。なお兄弟メソッドとして`String#sub`があります。`gsub`はヒットするものすべてに適用されますが、`sub`は最初にヒットしたパターンのみ置き換えます。使用頻度は`gsub`の方が高いです。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=gsub.rb"></script>

gsubにブロックを渡し、後方参照を使って10歳加齢させます。

<script src="https://gist.github.com/memerelics/d3f0b78ca0d3f488fef2.js?file=gsub2.rb"></script>

ブロックの中で、マッチした文字列を柔軟に書き換えられそうなことがわかると思います。


### 以上

以上で正規表現の基礎の解説は終わりです。正規表現は、例えばオライリーから出ている『[詳説 正規表現](http://www.amazon.co.jp/gp/product/4873113598?tag=cuzitisthere-22)』のように、本が一冊書けるほど奥が深いテーマであり、かつどんな言語であっても文字列を扱う時には必須の知識です。
