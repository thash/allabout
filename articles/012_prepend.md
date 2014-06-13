### Module#prependとは

Ruby2.0から追加された新機能のひとつに、`Module#prepend`があります。これはモジュールの機能を組み込む(Mix-inする)ときに使われるinclude、extendに続く3個目の方法であり、その特徴を簡潔に言うと

> Module#include に似た、Module#prepend という機能が追加されました。Module#include と異なり、prepend するクラス (モジュール) よりもメソッド探索順序を前にもってくる仕組みになります。
>
> [Rubyist Magazine - Ruby 2.0.0 の注意点やその他の新機能](http://magazine.rubyist.net/?0041-200Special-note#l11)

というものです。


* 参考
  * [Class: Module (Ruby 2.0.0)](http://ruby-doc.org/core-2.0/Module.html#method-i-prepend)
  * [#19 Module#prepend の紹介](http://www.atdot.net/~ko1/diary/201212.html#d19)


### Moduleの使い方

`Module#prepend`の機能を説明する前に、まずRubyのモジュールについて簡単に復習したいと思います。

Rubyのモジュールはクラスに似た機能ですが、インスタンスを生成することができません。また、クラスのように継承させることもできません。

<script src="https://gist.github.com/memerelics/353d3262804030da7dd3.js?file=module.rb"></script>

それでは何に使われるかというと、名前空間を区切ったり、機能を切り出して「つまみ食い」的にいろいろな場所へ取り込めるようにしたり、です。そして「取り込む」ときに使われるメソッドが先にも名前を出したincludeとextend、定義クラスまで明示すると`Module#include`と`Object#extend`です。

ただ、[extendは特異クラスにモジュールの機能を組み込むメソッド](http://ref.xaio.jp/ruby/classes/object/extend)であり少々prependとは毛色が違うため今回は脇においておき、[次のページ](/gm/gc/443728/2/)では「includeとprependの比較」という形で挙動を見ていこうと思います。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Module#prependで何が出来るようになったのか

私事ですが先日実家の香川県に帰ったところ、うどん屋と田んぼしかない不毛地帯であったのに、いつの間にかセブンイレブンが出店していることに感動しました。具体的な例を使うと記憶しやすいのではないかと考え、これを今回の題材に使ってみることにします。

まずはincludeを使った場合の例です。

<script src="https://gist.github.com/memerelics/353d3262804030da7dd3.js?file=include.rb"></script>

SevenElevenモジュールとKagawaクラスにそれぞれ同名のメソッド`drink`が定義されています。Kagawa内でSevenElevenをincludeしたのち`Kagawa#drink`を呼び出してみると、includeしたSevenElevenのものではなく、Kagawaクラスのdrinkが呼び出されます。

この理由は、`Kagawa.ancestors`メソッドを実行することで理解できます。

<script src="https://gist.github.com/memerelics/353d3262804030da7dd3.js?file=include_ancestors.rb"></script>

Object, Kernel, BasicObjectはどんなRubyのクラスにも入ってくる基礎的なクラスです。左が子孫、右が先祖という方向で順に並んでいます。`Kagawa#drink`が呼び出されたとき、Rubyは左(子孫)から順にさかのぼってメソッドを探します。先の例ではKagawaクラスのdrinkメソッドがヒットしたのでそこでメソッド探索を打ち切ったのでした。


ここでprependを使うと、メソッド探索においてモジュールのメソッドを先にヒットさせることができます。includeをprependに書き換えると次のようになります。

<script src="https://gist.github.com/memerelics/353d3262804030da7dd3.js?file=prepend.rb"></script>

SevenElevenが先にメソッド探索チェインに現れ、`Kagawa2#drink`の結果はSevenElevenモジュールで定義したdrinkとなります。

もちろん、子孫側のメソッド中でsuperを使えば、先祖側の同名メソッドを呼び出せます。

<script src="https://gist.github.com/memerelics/353d3262804030da7dd3.js?file=super.rb"></script>

superを呼び出す場所に注意してください。

* include
  * superを使うのは子孫側 = include「する」側(例ではKagawa3)
* prepend
  * superを使うのは子孫側 = prepend「される」側(例ではSevenEleven2)


[次のページ](/gm/gc/443728/3/)では実例として、Railsでよく使われる`alias_method_chain`をprependで書き換えてみます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### alias_method_chainをprependで書き換える

`Module#prepend`メソッドの応用範囲はいろいろとありますが、一例としてRailsの[alias_method_chain](http://apidock.com/rails/Module/alias_method_chain)と似た機能、prependで実装してみましょう。`alias_method_chain`はRails黒魔術のひとつで、ライブラリのメソッドをちょこっと書き換える時などに重宝していました。詳しくは [Rails: alias_method_chain: 既存の処理を修正する常套手段 TECHSCORE BLOG](http://www.techscore.com/blog/2013/02/27/rails-alias_method_chain-%E6%97%A2%E5%AD%98%E3%81%AE%E5%87%A6%E7%90%86%E3%82%92%E4%BF%AE%E6%AD%A3%E3%81%99%E3%82%8B%E5%B8%B8%E5%A5%97%E6%89%8B%E6%AE%B5/) などを参照してください。

実のところ、もともと`alias_method_chain`は`Module#prepend`の仮想敵でもありました。

> prependメソッドは、RailsコミッタでもあるYehuda Katzの提案で、 これがあればRailsのalias_method_chainを撲滅できる、と息巻いていた。 私もそう思う。
>
> [Matzにっき(2010-11-13)](http://www.rubyist.net/~matz/20101113.html)

さて、それでは実例を見ていきます。最初のrequire群は`alias_method_chain`を定義しているActiveSupportをBundlerでロードしている部分なので読み飛ばしてください。

<script src="https://gist.github.com/memerelics/353d3262804030da7dd3.js?file=amc.rb"></script>

drinkは`(ベース)_with_(機能)`という名前にエイリアスが貼られ、機能追加版のメソッドが呼び出されます。また、もともとのロジックが`(ベース)_without_(機能)`という名前で退避させられているのがわかります。

<script src="https://gist.github.com/memerelics/353d3262804030da7dd3.js?file=with.rb"></script>

これをprependで書くと、次のようになります。

<script src="https://gist.github.com/memerelics/353d3262804030da7dd3.js?file=prepend_coffee.rb"></script>

追加機能をモジュールの形で書き、ベースとなるクラスをオープンしてprependするだけです。すっきりと書けるうえ、`Coffee`モジュールは他のクラスに対してもprependして流用できそうです。


実例として`alias_method_chain`を書き換えを紹介しましたが、`Module#prepend`は他にもいろいろと活用できそうな機能です。何かカッコイイ例をご存じの方は教えて下さい。

以上で今回の記事は終わりです。
