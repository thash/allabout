### Ruby2.0の新機能

Rubyの最新バージョンは2014年5月現在、[2.1.2](https://www.ruby-lang.org/ja/news/2014/05/09/ruby-2-1-2-is-released/)です。
Ruby2.0は、いまから1年以上前の2013年2月にリリースされました。

[Ruby 2.0.0-p0 リリース](https://www.ruby-lang.org/ja/news/2013/02/24/ruby-2-0-0-p0-is-released/)

パフォーマンスが改善されているほか、

* キーワード引数
* `Enumerator::Lazy`クラスおよび`Enumerable#lazy`メソッド
* `Module#prepend`とRefinement
* シンボル配列リテラル `%i`

など、いくつかの新機能が盛り込まれています。1.8から1.9ほどの大きな変化はなく、後方互換性に配慮したバージョンアップとなっています。

今回の記事では、Rubyで遅延ストリームを実現する`Enumerator::Lazy`を紹介します。


### Enumerable#lazyで何が出来るか

具体的なイメージを固めるために、`Enumerable#lazy`メソッドを使う簡単な例を紹介します。

まず、1から100までの整数の中から素数を抜き出すコードは次のように書けます。

<script src="https://gist.github.com/memerelics/9fb939868500ceb11618.js?file=prime.rb"></script>

小さい方から100個の素数を取得したいときはどうすれば良いでしょうか。

1ずつ数を増やしながら素数かどうかを判定し、素数が100個溜まったところで停止させるというのもひとつのやり方ですが、先に`(1..100)`に対して行ったような関数型言語のスタイルをここでも使ってみましょう。
1から`Float::INFINITY`までのrangeの中から素数を抜き出し、最初100個を取得(`take(100)`)するコードは次のように書けます。

<script src="https://gist.github.com/memerelics/9fb939868500ceb11618.js?file=inf.rb"></script>

これを実行すると、無限長配列の全要素について素数かどうかの判定を行い、いつまで待っても結果が帰ってきません。
欲しいのは最初の100個なのだから、必要な分だけ素数判定を行い、100個の結果を返すようにできないものでしょうか。


そこで使えるのがRuby 2.0の新機能`Enumerable#lazy`メソッドです。これを`(1..Float::INFINITY)`の後に挟めば、次のように小さい方から100個の素数を求めることが出来ます。

<script src="https://gist.github.com/memerelics/9fb939868500ceb11618.js?file=lazy.rb"></script>


[次のページ](/gm/gc/442905/2/)では、`Enumerator::Lazy`クラスがどのような仕組みになっているか簡単に解説して行きます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Enumerable#lazyメソッドとEnumerator::Lazyクラス


[前ページ](/gm/gc/442905/)の最後の例で、`to_a`を付けていたことに気付かれたでしょうか。これを外すと、結果の素数リストではなく何やら妙なオブジェクトが返ってきます。

<script src="https://gist.github.com/memerelics/9fb939868500ceb11618.js?file=notoa.rb"></script>

これは入れ子になった`Enumerator::Lazy`クラスのインスタンスです。`Enumerable`モジュールをincludeしたクラス(たとえばArray, Hashなど)のインスタンスに対して`Enumerable#lazy`メソッドを使うと、`Enumerator::Lazy`クラスのオブジェクトが返されます。

<script src="https://gist.github.com/memerelics/9fb939868500ceb11618.js?file=obj.rb"></script>

`Enumerator::Lazy`は`Enumerator`のサブクラスとなっています。

<script src="https://gist.github.com/memerelics/9fb939868500ceb11618.js?file=anc.rb"></script>

`Enumerator::Lazy`ではmap, selectといった`Enumerator`に属するメソッドがオーバーライドされており、

<script src="https://gist.github.com/memerelics/9fb939868500ceb11618.js?file=methods.rb"></script>

これらのメソッドを使うと、すぐに結果を返すのではなく「あとでやる処理」として積み重ねられていきます。先の素数100個の例で得られた返り値をもう一度見てみましょう。

<script src="https://gist.github.com/memerelics/9fb939868500ceb11618.js?file=irego.txt"></script>

まず中心に`1..Infinity`の`Enumerator::Lazy`オブジェクトがあり、それに対して`select`をかけ、`take(100)`しているのがわかります。「あとでやる処理」の予定リストであり、`to_a`を付けるとしぶしぶ処理を実行して必要なだけの結果を返していたのです。ちなみに`to_a`には`force`というエイリアスも設定されています。


### 遅延評価について

このように、必要になるまで処理を実行しない評価手法を「[遅延評価](http://ja.wikipedia.org/wiki/%E9%81%85%E5%BB%B6%E8%A9%95%E4%BE%A1)」と言います。

> Enumerable#lazy を使うと、いままで map でできなかった「無限に続く列」や「巨大な列」、そして「終わりの分からない列」を対象として、map や select などの慣れ親しんだインターフェイスで操作できるようになります。
>
> [Rubyist Magazine - 無限リストを map 可能にする Enumerable#lazy](http://magazine.rubyist.net/?0041-200Special-lazy)

`Enumerator::Lazy`は、既存のRuby言語仕様の上にうまく遅延評価の仕組みを組み入れたライブラリです。
