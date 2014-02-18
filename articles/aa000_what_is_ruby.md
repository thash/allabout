### Rubyとは？

Rubyは1990年代に開発・公開されたオブジェクト指向のプログラミング言語で、生みの親はソフトウェア技術者のまつもとゆきひろ
(通称 Matz) さんです。


[![オブジェクト指向スクリプト言語 Ruby](http://img.allabout.co.jp/gm/article/432210/2013-10-18at106AM.png)](http://img.allabout.co.jp/gm/article/b/432210/2013-10-18at106AM.png "オブジェクト指向スクリプト言語 Ruby")

オブジェクト指向スクリプト言語 Ruby

「プログラミングを楽しむ」という哲学のもとに言語仕様が決められており、初学者を含めた多くの人にとって「読みやすく書きやすい」文法なのではないかと思います
(もちろん人それぞれ好みがありますが)。


また実用的なライブラリが標準で付属しており、ちょっとしたタスクをこなす普段使い言語としても比較的使い勝手が良くなっています。

 たとえば以下のスクリプトは「All
Aboutトップページに表示されている画像を保存する」処理を実行します。

 2013年にまつもとゆきひろ氏が講演の中で
[「Rubyは言語として2.0でほぼ完成」](http://itpro.nikkeibp.co.jp/article/NEWS/20130214/456322/)
と述べているようにある程度成熟してきている言語なので、今後バージョンアップで言語が劇的に変化して学習したことが無駄になる可能性は低いでしょう。


[![Ruby on Rails](http://img.allabout.co.jp/gm/article/432210/2013-10-20at852PM.png)](http://img.allabout.co.jp/gm/article/b/432210/2013-10-20at852PM.png "Ruby on Rails")

Ruby on Rails

Rubyのプロダクトとしては [Ruby on Rails](http://rubyonrails.org/) という人気フレームワークがあります(Railsについては回を改めて紹介する予定です)。このRailsの後押しもありRubyはWebプログラミングでよく使われていますが、Rubyの活躍する分野はWebだけではありません。




[![RubyMotion](http://img.allabout.co.jp/gm/article/432210/2013-10-20at854PM.png)](http://img.allabout.co.jp/gm/article/b/432210/2013-10-20at854PM.png "RubyMotion")

RubyMotion

組み込みシステムで使える [mruby](https://github.com/mruby/mruby) やRubyでiOSアプリを作る [RubyMotion](http://www.rubymotion.com/) など、ターゲットを広げながら今では世界中で使われています。日本発祥のプログラミング言語のため、日本語の情報が充実していて学習のハードルが低いことも初学者には嬉しい要素です。


 [次のページではプログラミング言語としてのRubyの特徴を挙げていきます。](/gm/gc/432210/2/)

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Rubyの特徴

プログラミング言語としてのRubyを百科事典的に一言で表すならば「オブジェクト指向のスクリプト言語」となります。さらに細かくRubyの特徴を数え上げると、次のようになるでしょうか。


-   すべてはオブジェクト
-   変数に型がない(動的型付け)
-   オープンクラス
-   クラスの単一継承とMix-in
-   クロージャを扱う構文(ブロック, Proc, lambda)

これらの特徴について詳細に説明することはしませんが、以下にコードの例を示します。まず今回の記事ではなんとなく眺めてRubyの雰囲気を掴んでもらえればと思います。




### すべてはオブジェクト



Rubyの[オブジェクト指向](http://ja.wikipedia.org/wiki/%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E6%8C%87%E5%90%91%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0)は徹底されており、(ごく一部の例外を除き)すべてのものが「オブジェクト」、すなわち何らかのクラスの[インスタンス](http://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%B3%E3%82%B9%E3%82%BF%E3%83%B3%E3%82%B9)になっています。Javaの[プリミティブ型](http://ja.wikipedia.org/wiki/%E3%83%97%E3%83%AA%E3%83%9F%E3%83%86%E3%82%A3%E3%83%96%E5%9E%8B)のようなものはありません。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=aa000-02.rb"></script> <br />



### 変数に型がない(動的型付け)



変数を使う前に宣言は必要ありません。さらに、変数にどんな[型](http://ja.wikipedia.org/wiki/%E3%83%87%E3%83%BC%E3%82%BF%E5%9E%8B)を入れてもエラーにはならず、何度でも再代入可能です。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=aa000-03.rb"></script> <br />


この特性は柔軟かつ素早いコーディングを可能にする一方で、静的型付け言語に比べてバグを生みやすいというデメリットもあります。ここは好き嫌いの別れるところかもしれません。


ちなみにRubyistはこのデメリット(コードが柔軟なのでバグを生みやすい)に自覚的であり、バグを防ぐために「テストを書く」ことが基本文化として浸透しているのは良いことだと言えるでしょう。



### オープンクラス



Rubyにとってクラスは「固定された」ものではありません。プログラマは好きなときに[クラス](http://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%A9%E3%82%B9_(%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF))を"オープン"し、機能拡張することができます。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=aa000-06.rb"></script> <br />

上の例で見たようString等の標準クラスはもちろん、自分で定義したクラスも自在に拡張できます。このように「言語を使うプログラマを信頼し、大きな(そして場合によっては危険な)力を与える」というのも、Ruby言語仕様の特徴の一つです。



[次のページではRubyの特徴のうち残り「クラスの単一継承とMix-in」「クロージャを扱う構文(ブロック, Proc, lambda)」について説明します。](/gm/gc/432210/3/)

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### クラスの単一継承とMix-in



Rubyのオブジェクト指向システムはクラスベースで設計されており、クラスは「[継承](http://ja.wikipedia.org/wiki/%E7%B6%99%E6%89%BF_(%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0))」することが出来ます。Rubyにおけるクラスの継承は、クラスの宣言時に
"class ChildClass< ParentClass" のように記述することで実現します。

 継承を説明する古典的な例として、動物のクラス定義を考えてみましょう。


<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=aa000-04.rb"></script> <br />




さて、実際のコードではシンプルな単一継承関係で話が終わることは稀です。どうしても複数の機能を抽象化したいケースが出てきます。親クラスを複数持つ継承スタイルを「多重継承」と呼びます。


ところが、多重継承を許すといろいろな不都合が起こることがわかってきました。1990年代以降に生まれた言語の多くは失敗の歴史を踏まえ、多重継承の不都合を避けつつメリットだけを享受しようと試行錯誤してきました。


Rubyは多重継承を許しません。つまりクラスの親クラスは必ず一つです。Rubyが多重継承の代わりに採用したのは、Lispのオブジェクト指向機能から生まれた"Mix-in"という方法でした。Mix-inでは、クラスを継承する代わりに「[モジュール](http://www.oki-osk.jp/esc/ruby/tut-05.html)」を"include"することで機能を取り込みます。


ネコは多少泳げるかもしれませんが、まぁここではクジラだけ泳げるという前提で考えます。WhaleクラスにSwimモジュールをMix-inしてみましょう。


<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=aa000-05.rb"></script> <br />




このようにして、Rubyのクラスは継承関係の外からも機能を"つまみ食い"的に取り込むことが出来ます。


### クロージャを扱う構文(ブロック, Proc, lambda)



最後に、このテーマは本格的に説明すると2～3回の連載でガッツリ扱えるほど濃厚なので、軽く触れる程度にします。


Rubyにもforやwhileは定義されていますがあまり使われず、その代わりにブロック付きのイテレータで繰り返し処理を書くことが多いです。

 ブロックは "do...end" もしくは "{...}" で記述します。

<script src="https://gist.github.com/memerelics/00f2a011c7c4970fe0ea.js?file=aa000-07.rb"></script> <br />


簡単なRubyの紹介は以上です。[次のページではしっかりRubyを学ぶ際にオススメの資料を紹介します。](/gm/gc/432210/4/)

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Rubyを学ぶために


 【書籍】


<div class="ItemCassette" name="Item:0003:4797372273">たのしいRuby 第4版</div>

入門書として気軽に読めます。プログラミングそのものに慣れている人にとっては初級すぎるかもしれません。



<div name="Item:0003:4873113946" class="ItemCassette">プログラミング言語 Ruby</div>

教科書的な本。説明が細かく、深く知りたい人におすすめ。


 【リンク】
 [逆引きRuby](http://www.namaraii.com/rubytips/)
 「こういうことがやりたいけどRubyではどう書くの？」という時に使えます。

 [Rubyist Magazine - るびま](http://magazine.rubyist.net/)Ruby界隈の空気を知っておくと勉強する上でもスムーズになるかもません。

