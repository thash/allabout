前回の [RSpecによるRubyプログラムの単体テスト](http://allabout.co.jp/gm/gc/450896/) 記事ではRSpecを紹介しました。今回紹介するminitestは、Rubyの標準ライブラリに含まれていたこともある軽量なテスティングフレームワークです。

[seattlerb/minitest - GitHub](https://github.com/seattlerb/minitest)

[Ruby on Rails本体](https://github.com/rails/rails)の開発ではminitestがテストライブラリに採用されています（[Railsのテストコード例](https://github.com/rails/rails/blob/master/activerecord/test/cases/associations/callbacks_test.rb)）。

ちなみにRubyテストライブラリの歴史および最近の動向については、以下の記事がわかりやすいと思います。


* [Rubyのテスティングフレームワークの歴史（2014年版） - ククログ(2014-11-06)](http://www.clear-code.com/blog/2014/11/6.html)
* [ruby 同梱の test-unit と minitest の今後 - HsbtDiary(2014-05-24)](http://www.hsbt.org/diary/20140524.html)


今回の記事ではminitestの使い方を簡単に紹介したあと、TDD、Test Driven Development: テスト駆動開発)という開発手法を紹介します。


### minitestのインストール・使い方

minitestは "minitest" というgemとして提供されているので、`gem install minitest`もしくはGemfileに記載して`bundle install`で使えるようになります。

以下のコード例では、本記事執筆時の最新バージョンである`minitest-5.5.1`を使用しますが、今後バージョンアップによって文法に違いが出る可能性も高いので注意して下さい。

簡単な使用例を以下に示します。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=first.rb"></script>

まず`Minitest::Test`を継承したクラスを定義して、共通初期化処理（この例の場合はMyClassクラスのインスタンスをテストするために`MyClass.new`しています）は`setup`という名前のメソッドの中に書きます。

あとは`test_`から始まるメソッドを作成すれば、それがテストケースとして扱われます。

テストケースの中で`assert_equal`というメソッドが呼ばれていますが、これは「第一引数と第二引数が等しいことを以てテスト成功とみなす」という意味です。

[Module: MiniTest::Assertions (Ruby 2.0)](http://ruby-doc.org/stdlib-2.0/libdoc/minitest/rdoc/MiniTest/Assertions.html#method-i-assert_equal)

上のドキュメントで定義を見るとわかるように`assert_equal(exp, act)`という順なので、第一引数がexpectationつまり「そうあるべき結果」を用意しておき、第二引数にはactualつまり「実行すると実際はどうだったか（テストしたいコードの実行結果）」を記述します。後のページでいくつか文法のバリエーションを紹介します。


### autorun

また`require 'minitest/autorun'`という記述がありますが、autorunをrequireすると、ファイルを実行するだけでテストが実行されるようになります。試してみましょう。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=first_run.sh"></script>

テストが通過しているのがわかります。なおこれは単に`require 'minitest'`のみを記述し、コード中で`Minitest.autorun`を呼び出しても同じ効果が得られます。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=autorun.rb"></script>


[次のページ](/gm/gc/452071/2/)では`assert_equal`以外のメソッドや、RSpec風のDSLが使える`minitest/spec`の解説を行います。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>



### assertとrefute


前のページで使用した`assert_equal`以外にさまざまなメソッドが用意されています。以下に一部を列挙します。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=asserts.rb"></script>

assert系メソッドは「予期した結果になる」テストケースを作成するものでしたが、逆に「◯◯にならないこと」をテスト成功条件とする、refute系メソッドもあります。似たようなrefute例を書いてみましょう。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=refute.rb"></script>


### spec記法

minitestは、RSpec(のような)記法もサポートしています。

[Class: MiniTest::Spec (Ruby 2.0.0)](http://ruby-doc.org/stdlib-2.0.0/libdoc/minitest/spec/rdoc/MiniTest/Spec.html)

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=spec.rb"></script>

どこかで見たことのある書式です。テスト対象オブジェクトをレシーバに`must_equal`メソッドを実行していますが、実は中では`assert_equal`を呼んでいるだけで、最後の例のようにspec記法で書きつつマッチャーだけassertを使うことも出来ます。

[Module: MiniTest::Expectations (Ruby 2.0.0)](http://ruby-doc.org/stdlib-2.0.0/libdoc/minitest/spec/rdoc/MiniTest/Expectations.html)

上のドキュメントを眺めると、`assert_`系は`must_`に、`refute_`系は`wont_`に対応していることがわかります。好みの記法を使い分けられるのも、minitestの良い所です。

それでは、[次のページ](/gm/gc/452071/3/)でminitestを使ったTDDの流れについて簡単に説明します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### TDDとは

TDDとはTest Driven Developmentの略語で、日本語ではテスト駆動開発と呼ばれます。Wikipediaによれば以下のように説明されています。


> プログラム開発手法の一種で、プログラムに必要な各機能について、最初にテストを書き（これをテストファーストと言う）、そのテストが動作する必要最低限な実装をとりあえず行った後、コードを洗練させる、という短い工程を繰り返すスタイルである。
>
> [テスト駆動開発 - Wikipedia](http://ja.wikipedia.org/wiki/%E3%83%86%E3%82%B9%E3%83%88%E9%A7%86%E5%8B%95%E9%96%8B%E7%99%BA)


そもそもテストは「テストする対象」がないと始めようがないので、まず機能を実装して、その後ちゃんと動くことを確認するためにテストを書く、という順序が道理に適っているように聞こえます。

それに対してTDDは、機能そのものが存在しない状態で「テストだけを先に」書いてしまい、そのテストを通すことを目的に最小限の実装を行う... というサイクルを繰り返すことによりプログラムを作成する開発手法です。一見「なんでそんなことをするのか」と不思議ですが、以下の様なメリットがあります。

* 設計（= あるべき状態）をテストとして記述するためゴールを見失わない
* 作業が小さくかつ明確なので手が止まりにくい
* 「常にテストされている状態」で実装されていくためプログラムが堅牢


TDD自体はどんなテストライブラリでも使えますが、minispecを使って実際にフィボナッチ数を求めるプログラムを書いてみましょう。


### TDDのサイクル実例

まずゴールを確認します。フィボナッチ数とは、以下のように定義される数列の要素です。

<div class="center200 article_image_box"><img width="200" height="95" class="article_image" alt="fib" src="//img2.allabout.co.jp/gm/article/452071/fib.png" />
<p class="cap">fib</p>
</div>


> この数列はフィボナッチ数列（フィボナッチすうれつ、Fibonacci sequence）と呼ばれ、
>
> 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, ...（[オンライン整数列大辞典の数列 A45](http://oeis.org/A000045)）
>
> と続く。最初の二項は0,1と定義され、以後どの項もその前の2つの項の和となっている。
>
> [フィボナッチ数 - Wikipedia](http://ja.wikipedia.org/wiki/%E3%83%95%E3%82%A3%E3%83%9C%E3%83%8A%E3%83%83%E3%83%81%E6%95%B0)


fibonacciという名前のメソッドに引数nを与えると、n番目のフィボナッチ数を返すことをゴールとします。

最小限から始めましょう。とりあえず0番目の数値は0だと言ってるので、テストケース`assert_equal 0, fibonacci(0)`を記載します。最初はfibonacciメソッド自体の中身はカラで構いません。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib1.rb"></script>

これを実行すると、当然ながら失敗します。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib1_run.sh"></script>

nilじゃなくて0を返したい、とのことなので0だけ記述します（そんなんでいいのか、というくらい「言われたことしかやらない」のがポイントです）。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib2.rb"></script>

これでとりあえず通過します。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib2_run.sh"></script>

次に `n = 1` のテストケースを追加して、同様に最低限の実装をします。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib3.rb"></script>

次に`n=40`までのテストケースを追加します。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib_rec_test.rb"></script>

さて、`n = 2`以上は決め打ちでは対応しきれそうにないので「n番目のフィボナッチ数はn-1番目とn-2番目の和である」という定義式をそのまま書いてしまいます。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib_rec.rb"></script>

これでテストは通過し、実装完了です。なんとなくTDDの手順は掴めたでしょうか。

[最後のページ](/gm/gc/452071/4/)では、ここで書いたコードのリファクタリングを行います。


<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### フィボナッチ数計算の効率化

さて、前ページで作成した再帰的なfibonacciメソッドは効率が悪く、40番目のフィボナッチ数を求めるだけで筆者の環境では約20秒かかってしまいます（計算結果をメモ化することで多少速くなりますが）。そこで、ループで回して先端値を更新していき、nに達したら止めるロジックに変更します。

テストを書いていると、安心して実装をごっそりリファクタリングすることができます。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib_loop.rb"></script>

こうすれば必要な回数分だけloopを回してcurrent(とprev)を更新していくだけで済むので、使用するメモリが爆発することもありません。テストが通ることを確認します。

<script src="https://gist.github.com/memerelics/5868eef6a36e638747af.js?file=fib_loop_run.sh"></script>

無事通過しました。`n = 40`まで含まれるテストケースがわずか0.001秒で終了しており、速度が改善されたことがわかります。このアルゴリズムなら、`n = 100000` 程度までなら1秒以内に結果が返ってきます。


### 以上

以上で今回の記事は終わりです。最後にTDDを紹介しましたが、テストコードによって正しいことが保証されながらプログラムが組み上がって行く様子を見るのは、なかなか爽快です。

[前回のRSpec記事](http://allabout.co.jp/gm/gc/450896/)、今回のminitest記事でテストの概念に触れた初学者で「テストするようなコード書いてないし...」という人は、ちょっとしたプログラムをTDDで作ってみると新しい発見があるかもしれません。