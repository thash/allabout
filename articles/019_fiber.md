### Fiberとは

今回の記事では、Fiberについて解説します。Fiberは [Rubyにおける並行処理とスレッド・プロセスの機能](http://allabout.co.jp/gm/gc/446444/) で解説した"Thread"に似ていますが、Threadにはない特徴を備えています。

RubyリファレンスマニュアルからFiberクラスの説明を引用してみましょう。

> ノンプリエンプティブな軽量スレッド(以下ファイバーと呼ぶ)を提供します。 他の言語では coroutine あるいは semicoroutine と呼ばれることもあります。 Thread と違いユーザレベルスレッドとして実装されています。
>
> [class Fiber | Ruby 2.1.0 リファレンスマニュアル](http://docs.ruby-lang.org/ja/2.1.0/class/Fiber.html)

概要は書かれている通りですが、より基礎的なところから別の言葉で説明を試みます。


### プリエンプティブ(Thread) vs 協調的(Fiber)

コンピュータにおいて、マルチタスクのスケージューリング方式には大きく分けて"Preemptive"と"Cooperative"の二種類があります。

Preemptive方式ではタスク自身が実行スケジュールをコントロールせず、OS(あるいはVM)に処理の切り替えを任せるものです。そもそも"preemption"とは「横取り」を意味します。Preemptiveなマルチタスクとは、途中で処理が別タスクに横取りされる可能性のある方法、と呼ぶことも出来ます。

Rubyでは[前々回の記事](http://allabout.co.jp/gm/gc/446444/)で取り上げたThreadクラスが、Preemptive方式に相当します。


それに対して"Cooperative"「協調的」なマルチタスクとは、タスク自身が「終わりましたので次どうぞ」と処理を親に返す方式です。ノンプリエンプティブ、とも呼ばれます。

Rubyにおいて、この協調的なタスクを扱うクラスがFiberなのです。

スレッドは生成されてすぐに処理が開始されますが、Fiberは処理の開始タイミングをコントロールできます。そのほか、「処理を途中まで実行しておいてストップし、また好きなタイミングで続きを実行する」ことも可能です。


[次のページ](/gm/gc/447245/2/)では、実際のコードでFiberの使い方を見ていきます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Fiberの基本的な使い方

それでは、Fiberクラスの挙動を観察してみてみましょう。Fiberは標準クラスなのでrequireは必要ありません。

`Fiber.new`するときには、Threadと同じくブロックを渡す必要があります。作成したFiberインスタンスは`resume`メソッドを持ち、これを呼び出すとブロックが実行されます。

<script src="https://gist.github.com/memerelics/c8a3c9233cb0c2a61f07.js?file=new.rb"></script>

ただ「ブロックのコードを任意の場所で呼び出せる」だけではProcと変わりません。`Fiber.yield`とresumeを組み合わせるのが、Fiberの真の使い方です(ただの`yield`ではなくFiberクラスのクラスメソッド`Fiber.yield`であることに注意してください)。

<script src="https://gist.github.com/memerelics/c8a3c9233cb0c2a61f07.js?file=resume.rb"></script>

`Fiber#resume`を呼び出すと子ファイバーにコンテキストを切り替え、ブロック中で`Fiber.yield`した時点でまた親にコンテキストを切り替えます。再度resumeすると前回の続きからブロックの処理が始まり、また`Fiber.yield`で親に戻ってきます。親と子がキャッチボールのように処理を切り替え、「協調的に」動作しています。

また、fiberをresumeできるのは「yieldの数+1回」であり、さらにresumeしようとするとFiberErrorが発生し"dead fiber called"だと怒られることもわかります。

状態を変えながらloopの中で無限に`Fiber.yield`を呼べるようにすれば、以下のような使い方も可能です。Fiberを用いて、resumeするたびにフィボナッチ数を順々に返すオブジェクトを作っています。

<script src="https://gist.github.com/memerelics/c8a3c9233cb0c2a61f07.js?file=fib.rb"></script>

このように「計算を途中までで止めて部分的な結果を返し、また続きから計算を再開する」ようなモノを <a href="http://ja.wikipedia.org/wiki/%E3%82%B8%E3%82%A7%E3%83%8D%E3%83%AC%E3%83%BC%E3%82%BF_(%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0)">ジェネレータ</a> と呼びます。FiberはRubyでジェネレータを実装する際の有力な手札となります。

ここまでを踏まえ、再びリファレンスマニュアルから引用します。


> Thread クラスが表すスレッドと違い、明示的に指定しない限り ファイバーのコンテキストは切り替わりません。 またファイバーは親子関係を持ちます。Fiber#resume を呼んだファイバーが親になり 呼ばれたファイバーが子になります。親子関係を壊すような遷移(例えば 自分の親の親のファイバーへ切り替えるような処理)はできません。 例外 FiberError が発生します。 できることは
>
> * Fiber#resume により子へコンテキストを切り替える
> * Fiber.yield により親へコンテキストを切り替える
>
> の二通りです。
>
> [class Fiber | Ruby 2.1.0 リファレンスマニュアル](http://docs.ruby-lang.org/ja/2.1.0/class/Fiber.html)

Fiberは親子関係を持ち、親からは`resume`、子からは`Fiber.yield`という非対称な呼び出し関係にあるため、コルーチンではなくセミコルーチンと呼んだほうが正確です。


[最後のページ](/gm/gc/447245/3/)では、非対称な親子関係に制限されない、`Fiber#transfer`メソッドの使い方を解説します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Fiber#transfer

`require 'fiber'` すると`Fiber#transfer`が利用可能になります（[開発初期段階では素のFiberとは区別されFiber::Coreという名前だった](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/31583)ようです。


> 自身が表すファイバーへコンテキストを切り替えます。
> 自身は Fiber#resume を呼んだファイバーの子となります。 Fiber#resume との違いは、ファイバーが終了したときや Fiber.yield が呼ばれたときは、 ファイバーの親へ戻らずにメインファイバーへ戻ります。
>
> [instance method Fiber#transfer | Ruby2.1.0リファレンスマニュアル](http://docs.ruby-lang.org/ja/2.1.0/method/Fiber/i/transfer.html)

まずfiberの中から別のfiberをresumeする例を示します。

<script src="https://gist.github.com/memerelics/c8a3c9233cb0c2a61f07.js?file=no_transfer.rb"></script>

この場合、`f2.resume`の返り値はf2ファイバー自体が返す値となります。

一方`Fiber#transfer`を使うと、

<script src="https://gist.github.com/memerelics/c8a3c9233cb0c2a61f07.js?file=transfer.rb"></script>

f2の中から、強引にf1のコンテキストに切り替えることが出来ます。


### まとめ

以上でFiberの解説は終わりです。

Fiberは日々のプログラミングで気軽に使えるような機能ではないかもしれませんが、RubyにはThreadとは異なる並行処理へのアプローチがあるということ、またI/Oがコードのボトルネックになった時にパフォーマンスを改善する切り口になり得るということを覚えておくと良いと思います。

良い応用例が見つかったら、また別途記事にする予定です。
