### キーワード引数とは

Ruby2.0の新機能のひとつが「キーワード引数」です。キーワード引数とはメソッドに引数を「渡す時」に名前を付けるもので、Pythonなどの言語でもサポートされています。


### キーワード引数の使い方

まず比較のために、通常のメソッド定義方法を示します。引数が渡されなかった時のデフォルト値は1とします。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=parameters.rb"></script>

一方、キーワード引数を使うには、メソッドを `def method_name(var: default)` の形式で定義し、利用時には引数名と値を`method_name(var: value)`の形で呼び出します。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=cube.rb"></script>

引数名を指定しないとエラーとなり、引数なしで実行すると、定義時の`(n: 1)`がデフォルトとして使われます。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=exec.rb"></script>

この単純な例では今ひとつメリットが分かりづらいかと思いますので、[次のページ](/gm/gc/443845/2/)では、Ruby1.9までも使われてきた「擬似キーワード引数」と比較しながら、キーワード引数が使えると便利なケースを紹介します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Ruby1.9までの慣習、擬似キーワード引数

キーワード引数のメリットを表す例として、Rubyメソッドの「よくある使われ方」である「擬似キーワード引数」について説明します。

一般的に、メソッドの利用パターンが複雑化してくると引数の数も増え、引数の順序を間違えずに呼び出すのが難しくなります。説明のために、以下の様な引数のごちゃごちゃしたメソッドを用意します。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=coffee.rb"></script>

こうしたメソッド定義においては、呼び出し時にたとえば次のような問題に直面しがちでした。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=prob.rb"></script>

このように引数の順序が固定だと使い勝手が悪いため、Ruby1.9まで慣習的に使われてきたのが「擬似キーワード引数」というイディオムです。これは、必須ではない引数などを最後にハッシュとして渡し、それをメソッド内で分解、利用するものです。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=pseudo_keyword_arguments.rb"></script>

`*args`は任意長引数で、2個目以降の引数をすべて配列としてargsの中に格納しています。最後の要素がHashであるときはメソッド内でそれをオプションとみなして利用され、一方、オプションが指定されていない場合は `||` 演算子の右側に置いたデフォルト値が使われます。

以上のようにメソッドを定義してやることで、次のようにオプション名を明示しつつ、シンプルに呼び出すことが出来ます。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=pseudo_keyword_arguments_use.rb"></script>


[次のページ](/gm/gc/443845/3/)では、同じ題材でキーワード引数を使った場合の書き方を示し、Ruby2.1で追加された改良点にも触れます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### キーワード引数を使うと

前ページの例をキーワード引数を使って定義すると、次のように書けます。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=keyword_arguments.rb"></script>

呼び出し方は擬似キーワード引数の場合と同じです。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=keyword_arguments_use.rb"></script>

「どのようなオプションが渡せるか、それぞれのデフォルト値が何か」がdef行に記述されることで、メソッド内容から引数処理がなくなり、行数が減るとともに本質的な処理のみが残ることになります。


### Ruby2.1での改良

2.0まではデフォルト値の指定が必須でしたが、2.1から、デフォルト値のない定義も可能になりました。

この場合、`n`を渡さないとエラーとなります。

<script src="https://gist.github.com/memerelics/82825ae61a8e7eb5a18d.js?file=nodefault.rb"></script>



以上でキーワード引数の紹介は終わりです。

