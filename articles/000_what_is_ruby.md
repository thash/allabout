### Hello, Ruby!

[Ruby](https://www.ruby-lang.org/ja/) は1990年代に開発・公開されたオブジェクト指向のプログラミング言語で、生みの親はソフトウェア技術者のまつもとゆきひろ (通称 Matz) さんです。

[![オブジェクト指向スクリプト言語 Ruby](http://img.allabout.co.jp/gm/article/432210/2013-10-18at106AM.png)](https://www.ruby-lang.org/ja/ "オブジェクト指向スクリプト言語 Ruby")

「楽しくプログラミングできる言語」 という哲学に基づく設計は、初学者を含めた多くの人にとって「読みやすく書きやすい」文法ではないかと思います。

例えばJavaは、ただ文字を出力するだけのプログラムであっても`static void main...`など長々としたコードやクラスの作成が必須ですが、Rubyには初心者の混乱する「おまじない」はほとんどありません。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=hello.rb"></script>

また、Rubyはインタプリタ型言語ですのでJavaやCのようにコンパイルが必要なく、ターミナルで`ruby`コマンドに`.rb`で終わるファイルを渡してやるだけで実行されます。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=exec.sh"></script>

ちなみにコード中に出てきた`puts`を使って、[標準出力](http://ja.wikipedia.org/wiki/%E6%A8%99%E6%BA%96%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%A0)に実行結果を出力しています。Javaで言う`System.out.println`に相当します。

Rubyでは`#`はコメントで、`#`以降に書いたものはすべて無視されます。
`#=>` は「この行を実行した結果はこうなるよ」という説明のためによく使われる形で、本記事でもこれを使ってコードの結果を示していきます。


自然に読み書きできることに加えて実用的なライブラリが標準で付属しており、ちょっとしたタスクをこなす普段使いツールとしても使い勝手が良い言語です。


### 最近のRuby事情

2014年2月現在の最新安定バージョンは2.1.0です。 2013年にまつもとゆきひろ氏が講演の中で
[「Rubyは言語として2.0でほぼ完成」](http://itpro.nikkeibp.co.jp/article/NEWS/20130214/456322/)
と述べているようにある程度成熟してきている言語なので、「バージョンアップで言語が劇的に変化してしまい、学習したことが無駄になる」ような可能性は低いでしょう。


Rubyのプロダクトとして人気の高いものに、 [Ruby on Rails](http://rubyonrails.org/) というWebフレームワークがあります。Railsについては回を改めて紹介する予定です。
Railsの後押しもありRubyはWebプログラミングでよく使われていますが、Rubyの活躍する分野はWebだけではありません。

[![Ruby on Rails](http://img.allabout.co.jp/gm/article/432210/2013-10-20at852PM.png)](http://rubyonrails.org/ "Ruby on Rails")

組み込みシステムで使える [mruby](https://github.com/mruby/mruby) やRubyでiOSアプリを作る [RubyMotion](http://www.rubymotion.com/) など、ターゲットを広げながら今では世界中で使われています。
日本発祥のプログラミング言語のため、日本語の情報が充実していて学習のハードルが低いことも初学者には嬉しい要素です。

[![RubyMotion](http://img.allabout.co.jp/gm/article/432210/2013-10-20at854PM.png)](http://www.rubymotion.com/ "RubyMotion")

[次のページ](/gm/gc/432210/2/)から、Rubyを使うのが初めてという人を対象にRubyの特徴を挙げていきます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Rubyの特徴

プログラミング言語としてのRubyを百科事典的に一言で表すならば「オブジェクト指向のスクリプト言語」となります。自他ともに認める言語マニアであるMatz氏は新旧いろいろな言語から良いところを取り込み、それらをバランス良く練り上げ、統合しています。

本記事ではRubyの仕様について詳細に説明することはしませんが、知っておくと良いRubyの特徴を以下にいくつか挙げ、簡単な説明を加えて行きます。

- 変数の宣言不用・型がない
- すべてはオブジェクト
- クラスと継承
- ブロックとイテレータ

今回の記事ではなんとなくコード例を眺めて、Rubyの雰囲気と魅力を感じてもらえれば幸いです。


### 変数の宣言不用・型がない

Rubyでは、変数を使う前に宣言は必要ありません。たとえば以下の例のように、

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=var.rb"></script>

`=`の左に変数名、右に代入する値を書けばその行が実行された時点で変数が定義されます。

また、変数にどんな[型](http://ja.wikipedia.org/wiki/%E3%83%87%E3%83%BC%E3%82%BF%E5%9E%8B)の値を入れてもエラーにはなりません。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=type.rb"></script>

これはコードに柔軟性を与える一方、変数にどんな値が入っているのか実行するまでわからないため、プログラマは誤解を与えないわかりやすいコードを書くように気をつける必要があります (たとえば、strという名前の変数に数値が入っていると混乱を引き起こしますよね)。


### すべてはオブジェクト

Rubyは徹底した[オブジェクト指向](http://ja.wikipedia.org/wiki/%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E6%8C%87%E5%90%91%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0)で設計されており、すべてのものが「オブジェクト」で、何らかのクラスの[インスタンス](http://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%B3%E3%82%B9%E3%82%BF%E3%83%B3%E3%82%B9)として存在しています。

クラスからインスタンスを作成する方法は次節「クラスと継承」で説明します。

メソッドを呼び出すには、呼び出し元（レシーバ）のオブジェクトにドットでメソッド名を繋げます。つまり`abc.hoge`と書いた場合、これは「abcオブジェクトの持つhogeメソッドを実行している」ということを表します。
メソッド呼び出しに引数を渡す時は引数を`()`カッコの中に入れます。このカッコは省略可能であり、`[1,2,3].push(4)`は`[1,2,3].push 4`とも書けます。

あるオブジェクトがどのクラスのインスタンスかを調べる「`class`」というメソッドを使って、いくつかのオブジェクトのクラスを調べてみましょう。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=noprim.rb"></script>

上の例でわかるように、Javaでは[プリミティブ型](http://ja.wikipedia.org/wiki/%E3%83%97%E3%83%AA%E3%83%9F%E3%83%86%E3%82%A3%E3%83%96%E5%9E%8B)になっている真偽値やnull(Rubyではnilがこれにあたります)も、Rubyではクラスのインスタンスです。

ちなみに「methods」メソッドを使えば、そのオブジェクトの持つメソッド一覧を調べることが出来ます。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=methods.rb"></script>

いろいろなオブジェクトのクラスを調べたりメソッド一覧を眺めると、勉強になるのでオススメです。


[次のページ](/gm/gc/432210/3/)では、Rubyにおけるクラスの扱いを紹介していきます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### クラスとインスタンス

オブジェクト指向とクラスは必ずしもセットというわけではありません（例えばJavaScriptはオブジェクト指向の言語ですが、その中核にあるのはクラスではなくプロトタイプチェーンです）が、Javaや`C#`、Rubyなどはクラスの概念をベースに設計されたオブジェクト指向言語です。

Rubyにおいてクラスの定義は`class ClassName ... end`で行い、クラスのインスタンスを作成するためにはnewメソッドを呼び出します。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=class.rb"></script>

`def`はメソッドを定義するための構文で、クラス内で定義したメソッドはそのインスタンスに対して呼び出すことができます。


ところで、前ページでは「`"moji"`」はStringクラスのインスタンスでした。newを使っていなかったのにどうやってインスタンスが出来たのでしょう？

これは、「`""`」がStringクラスのインスタンスを作成するリテラルだからです。リテラルとは、プログラミング言語の用意した、newしなくても何かのクラスのオブジェクトを作れる記法を指します。
他の例として「`[1,2,3]`(Array)」、「`{x: 1, y: 2}`(Hash)」などもリテラルです。


### 継承

既存のクラスを継承させたいとき、`class ClassName < ParentClass`という書き方で親クラスを表します。記事内では継承という概念については詳しく触れませんが、もし初めて聞く場合は「親クラスの機能を引き継ぎつつ、新しいクラスを定義する」ことを指すと考えて下さい。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=inheritance.rb"></script>

先ほど作成したDogクラスを継承したBeagleクラスを作成し、`say`メソッドを定義しています。この中で`super`メソッドを呼ぶと、その場で親クラスの同名メソッドを実行します。

クラスの継承は便利な機能であり、正しく使えばコードを簡潔にしてくれます。Rubyにはクラスの他にモジュール(module)という機能もありますが、話が入り組んでくるのでこれは回を改めて取り扱うことにします。


### オープンクラス

Rubyにとって、クラスはたった一度の定義で固定されるものではありません。プログラマは好きなときにクラスを「オープン」し、機能拡張することができます。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=openclass.rb"></script>

さっきと同じDogという名前でクラス定義を行ってみると、先に定義した`say`も失われることなく、引き続き使えていることがわかります。つまり`class Dog`で新しい定義が上書きされるのではなく、既存のDogクラスに機能を追加することができるのです。

自分で定義したクラスはもちろん、StringやArrayといった標準クラスも自在に拡張できます。このように「言語を使うプログラマを信頼し、大きな(そして場合によっては危険な)力を与える」というのも、Ruby言語仕様の特徴の一つです。


[次のページ](/gm/gc/432210/4/)ではRubyの特徴の最後の一つ「ブロックとイテレータ」を解説し、学習のための書籍とリンクをご紹介します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### ブロックとイテレータ

Rubyにもfor, whileは実装されていますが、ほとんど使われません。代わりにRubyは「イテレータ(iterator)」を使って繰り返し処理を行います。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=each.rb"></script>

Arrayクラスのオブジェクトに対して`.each`というメソッドを`do...end`付きで実行すると、配列の1個1個の要素に対して`do...end`の中身が順番に実行されます。`|i|`の部分には、そのとき順番の回ってきた要素が入ります。

「`do ... end`」あるいは「中括弧 `{...}`」で囲まれた部分をブロック(block)と呼びます。中括弧を使う場合は改行せず1行に書くことが多いです。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=each2.rb"></script>

ブロックの中に書いたコードは使いまわすことが出来ます。上の例で言うと`puts 1 * 1`、`puts 2 * 2`、といちいち書かずに`puts i * i`を使いまわしています。

ブロックは、Rubyコードの「Rubyっぽさ」をかもし出す主要因であるように思えます。最初は繰り返し処理で使う程度ですが、慣れてくると別名のメソッドに分離するまでもない処理を共通化できるため、便利です。


簡単なRubyの紹介は以上です。最後に、Rubyを学ぶ人のために参考書籍とリンクをいくつか挙げておきます。


### 参考資料: 書籍】

<div class="ItemCassette" name="Item:0003:4797372273">たのしいRuby 第4版</div>

入門書として気軽に読めます。プログラミング自体が初めての人はこの本から始めると良いと思います。


<div name="Item:0003:4873113946" class="ItemCassette">プログラミング言語 Ruby</div>

教科書的な本。既に他の言語でプログラミング経験があり、Rubyの仕様について知りたい人におすすめ。


### 参考資料: リンク

 [逆引きRuby](http://www.namaraii.com/rubytips/)
 「こういうことがやりたいけどRubyではどう書くの？」という時に使えます。

 [Rubyist Magazine - るびま](http://magazine.rubyist.net/)Ruby界隈の空気を知っておくと勉強する上でもスムーズになるかもません。

