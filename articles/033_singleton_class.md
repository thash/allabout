Rubyは比較的読みやすく書きやすい言語ですが、少し踏み入ったところでは独特の設計も少なくありません。今回扱う「特異クラス・特異メソッド」もそのひとつで、はじめて出会うと面食らう概念です。しかし考え方を知るとRubyのオブジェクト指向設計への理解が深まる部分でもあるので、今回の記事では特異クラス・特異メソッドを紹介するとともに、いくつかの方面から解説を加えて行きます。


### 特異メソッド

説明を簡単にするため、先に特異メソッドを取り上げます。特異メソッドの定義・使い方自体は単純なもので、以下のように書きます。

<script src="https://gist.github.com/memerelics/1b2370b2c92bc96ac8c1.js?file=singleton_method.rb"></script>

メソッド定義時に、特定のオブジェクト（例ではHogeクラスのインスタンスである"h"が該当します）にドットをつなげる形でメソッド名を記述しています。こうすることで、他のHogeクラスインスタンスには存在しないメソッドを"h"で独自に定義することが出来ます。


### 特異クラス

さて、上の特異メソッドもスコープが特定のオブジェクトに限られているだけで、メソッドであることには変わりありません。

一方、Rubyの他の部分では「メソッドはクラスに紐づく」設計になっています。つまり、メソッドはクラスに定義され、クラスをnewしてできるインスタンスたちはメソッドを共有するという設計です。

「メソッドはクラスに紐づく」というRubyオブジェクト指向の基本原則を、特異メソッドというイレギュラーな存在と両立させるには、「すべてのオブジェクトは自分だけの隠しクラスを持つ[\*1](#note1)」という仮定を追加してやることです。
そうすれば、特異メソッドは「自分だけのクラスに定義されたメソッド」と考えることができて（一応）筋が通ります[\*2](#note2)。

この「自分だけのクラス」が特異クラスで、`singleton_class`メソッドで参照することが出来ます。

<script src="https://gist.github.com/memerelics/1b2370b2c92bc96ac8c1.js?file=singleton_class.rb"></script>

単にObjectをnewしただけのインスタンスでも `#<Class:#<Object:0x007fea6187f318>>` という特異クラスを持っていることがわかります。
なおnilやfalseなどに対して `singleton_class` を呼んでも、通常のclass呼び出しと同じく `NilClass`、`FalseClass` が返るだけになります。

<script src="https://gist.github.com/memerelics/1b2370b2c92bc96ac8c1.js?file=nil_singleton_class.rb"></script>


ちなみに、当初は正式な英語名が与えられていなかったことから"eigenclass"や"metaclass"などと呼ばれることもありますが、現在はコアライブラリのメソッド名になったこともあり"singleton class"でほぼ固まってきているようです。詳しい歴史的経緯については以下のStackOverFlowが参考になります。

[In Ruby, are the terms "metaclass", "eigenclass", and "singleton class" completely synonymous and fungible? - Stack Overflow](http://stackoverflow.com/questions/25336033/in-ruby-are-the-terms-metaclass-eigenclass-and-singleton-class-complete)


[次のページ](/gm/gc/453836/2/)では、特異クラスをオープンする方法、クラスメソッドとの関連を解説します。


* <span id="note1">*1</span> `singleton_class` メソッドのドキュメントに "Returns the singleton class of obj.  This method creates a new singleton class if obj does not have it." とあることから、オブジェクトが生成された時点で特異クラスを持つようになるわけではなく、必要とされた時に作られるようです。
* <span id="note2">*2</span> Rubyの設計時にこのような議論があったわけではなく、考え方の一例です。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### 特異クラスへのアクセス

先述のように、すべてのオブジェクトは自身の特異クラスを持ちます。この特異クラスを拡張 (例えばインスタンスメソッドを追加するなど) したいときはどうすれば良いでしょうか。
特異クラスには名前が与えられていないため、普通のクラスのように `class 特異クラス名 ... end` という構文でアクセスすることは出来ません。

その代わりに使うのが、 `class << オブジェクトA ... end` という構文です。`<<` で開いたスコープ内部では、コンテキストがオブジェクトAの特異クラスへと切り替わっています。

<script src="https://gist.github.com/memerelics/1b2370b2c92bc96ac8c1.js?file=open.rb"></script>

`def obj.hi` で定義しても、上記のように`<<`で特異クラスを開いてメソッドを定義しても、結果は同じです。


### クラスはオブジェクトである

ここで少し余談として、Rubyが「クラス」をどう扱っているか復習します。

Rubyにおいて、(ほぼ)すべてはオブジェクトです。クラスも例外ではなく、オブジェクトです。正確に言うと "Class" という名前のクラスが上位に存在し、StringやArrayやIntegerといったクラス、また自身で定義したHogeクラスなども、すべて"Class"クラスのインスタンスとして生成されます。

<script src="https://gist.github.com/memerelics/1b2370b2c92bc96ac8c1.js?file=class.rb"></script>

クラスもオブジェクトであるということは、もちろん特異クラスを持っているはずです。`<<`でオープンし、特異メソッドを追加することが出来ます。

<script src="https://gist.github.com/memerelics/1b2370b2c92bc96ac8c1.js?file=singleton_class_of_classes.rb"></script>

最後の `String.shout` は特異クラスの呼び出しですが、クラスメソッドの呼び出しのように見えます。事実、**クラスメソッドと呼ばれているものは特異メソッドの一種**です。


### クラスメソッドは特異メソッドの一種である

特異クラス・特異メソッドの知識を得たうえでRubyのクラスメソッド定義を見てみます。

<script src="https://gist.github.com/memerelics/1b2370b2c92bc96ac8c1.js?file=class_methods.rb"></script>

クラス定義中に`class << self ... end`と書くのはクラスメソッドを定義する際によく使われるイディオムで、`def self.method_name` としても結果は同じです。


### 以上

以上で特異クラス・特異メソッドの説明は終わりです。普段よく目にするクラスメソッドは実は特異メソッドだった、という展開で読み進められるような順序で進めてみました。
