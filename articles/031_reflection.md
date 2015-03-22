リフレクションとは、プログラムの(実行前ではなく)実行時にプログラムそのものの情報を参照・書き換えることができる特性を指します。

> In computer science, reflection is the ability of a computer program to examine (see type introspection) and modify the structure and behavior (specifically the values, meta-data, properties and functions) of the program at runtime.
>
> [Reflection (computer programming) - Wikipedia, the free encyclopedia](http://en.wikipedia.org/wiki/Reflection_%28computer_programming%29)

Rubyは豊富なリフレクション機能を持っています。今回の記事では関連メソッドを簡単に紹介して行きたいと思います。


### eval

特に中心となるメソッドとして、evalが挙げられます。evalは"evaluate(評価する)"から名付けられた、文字列を引数として取り、文字列の内容をRubyコードとして実行するメソッドです。

<script src="https://gist.github.com/memerelics/0d8c5e7bd42a88537871.js?file=eval.rb"></script>

ふたつめの例ではヒアドキュメントで文字列をevalに渡し、文字列の内容を`#{...}`による埋め込みで書き換えつつ繰り返すことで、冗長なメソッド定義のコード量を抑えています。

ちなみにメソッド定義に限れば、 evalを使わずとも`define_method` という専用のメソッドもあります。

<script src="https://gist.github.com/memerelics/0d8c5e7bd42a88537871.js?file=define_method.rb"></script>


### コンテキストとself

以下で「コンテキスト」という言葉を使っていきますが、これは「そのコードが"どこ"で実行されたものとみなすか」を指します。具体的には「XのコンテキストでコードCを評価する」とは

* コードC内のselfがXになる
* コードC内から参照可能な変数セット(環境)がXと同じになる

という意味を持ちます。


### eval族

evalは呼び出された箇所のコンテキストで文字列をRubyコードとして評価しますが、`instance_eval`、`class_eval`、`module_eval`を使うと、評価コンテキストを切り替えることが出来ます。

<script src="https://gist.github.com/memerelics/0d8c5e7bd42a88537871.js?file=instance_eval.rb"></script>

例のように`instance_eval`を使うと、privateなメソッドを呼び出したり、アクセサの定義されていないインスタンス変数を参照することが出来ます。

また、`class_eval`というメソッドもあります。これはクラスを引数に取り、文字列またはブロックをそのクラス定義のコンテキストで評価します。

<script src="https://gist.github.com/memerelics/0d8c5e7bd42a88537871.js?file=class_eval.rb"></script>

`module_eval`は`class_eval`のエイリアスなので機能は同じです。文脈に応じて使い分けます。


[次のページ](/gm/gc/453135/2/)では、セッター/ゲッター系のメソッドとbindingについて説明します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### bindingとEval

[前のページ](/gm/gc/453135/)で「evalは呼び出された箇所のコンテキストでコードを評価する」と書きましたが、evalの第二引数にBindingオブジェクトを渡すと、Bindignのコンテキストで評価させることが出来ます。

<script src="https://gist.github.com/memerelics/0d8c5e7bd42a88537871.js?file=binding.rb"></script>


### 変数アクセスを提供

改めて言うまでもありませんが、通常ローカル変数は「`x = 1`」とすれば宣言・束縛が行われ、値の参照には単に「`x`」と書けば良いだけです。任意のbindingで定義されている変数を参照にするには

* `Binding#local_variables` ※
* `Binding#local_variable_set`
* `Binding#local_variable_get`

などを使います。

※ Ruby2.1以前はプライベートメソッド。詳しくは[前回の記事](http://allabout.co.jp/gm/gc/452102/2/)を参照してください。

同様に、レシーバのコンテキストにおけるインスタンス変数、クラス変数にアクセスする次のようなメソッドが用意されています。

* `Kernel#instance_variables`
* `Kernel#instance_variable_set`
* `Kernel#instance_variable_get`
* `Module#class_variables`
* `Module#class_variable_set`
* `Module#class_variable_get`

また、

* `Module#constants`

は、レシーバのコンテキストで定義されている定数の一覧を返します。

<script src="https://gist.github.com/memerelics/0d8c5e7bd42a88537871.js?file=constants.rb"></script>


以上でリフレクションメソッド群の紹介は終わりです。コードの解析を行うときに必須のメソッドたちなので、今後の記事でも必要に応じて参照して行きます。
