### Rakeとは

[Rake](http://rake.rubyforge.org/) とはRuby製のビルドプログラムで、プログラム実行を"タスク"という単位でまとめて扱うことが出来ます。"make"という、C言語で書かれ古くから使われてきたUNIXのビルドプログラムに影響を受けています。

> Rake, a simple ruby build program with capabilities similar to make.

Rakeを使い始めるには、"rake"のgemが必要です。[rbenvを使ってRubyをインストール](http://allabout.co.jp/gm/gc/431930/)していれば既にrakeが入っているはずですが、最新版(2014年2月現在10.1.1)に上げておきましょう。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=install.sh"></script>

gemについては過去の記事「[RubyGems (gem) の使い方・インストール方法 [Ruby] All About](http://allabout.co.jp/gm/gc/439246/)」を参考にしてください。

さて、これでrakeが利用できるようになったので、コマンドを実行してみます。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=norakefile.sh"></script>

Rakefileがないよ、と怒られてしまいました。rakeを実行する時は、タスクを定義した"Rakefile"をカレントディレクトリに置いておく必要があります(makeをご存知の方であれば"Makefile"に相当するものだとすぐわかるでしょう)。

[次のページ](/gm/gc/439680/2/)では、少しずつ実行しながらRakefileの書き方を解説していきます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### Rakefile

Rakefileの文法は、通常のRubyプログラムにいくつかrake用の記述を追加したものです。つまりふつうRubyプログラムで実行可能なことは何でもできます。

最初の例として、挨拶だけするタスクを定義してみます。以下の内容をRakefileという名前で保存してください。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=hello.rb"></script>

`task :taskname` がタスクの定義で、`do...end`の中にタスクの内容を記述します。これで、コマンドラインから`rake hello`を叩けば`hello`という名前で定義したタスクが実行されます。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=dohello.sh"></script>

ここで、次のように`:default`を`:hello`に設定しておけば、

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=default.rb"></script>

`rake`を叩くだけで`:hello`を実行できます。利用頻度の高いタスクはデフォルトにしてしまうと良いでしょう。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=dodefault.sh"></script>


### rakeに引数を渡す

先ほどの`:hello`タスクによく似た`:goodbye`タスクを作成し、今度は相手の名前を引数に受け取るようにしてみましょう。`task :goodbye, [:name, :nickname]`とタスク名の後に引数リストを追加し、さらにブロック引数をふたつ(`t`と`args`)定義します。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=args.rb"></script>

ここで`t`は`Rake::Task`クラスのインスタンス、`args`は `Rake::TaskArguments`クラスのインスタンスです。`Rake::TaskArguments`に対して引数名のメソッドを呼び出すことで、引数が取得できます。

引数付きのrakeコマンドを使うためには、以下のように、タスク名に続けた角カッコ(`[]`)の中にカンマ区切りで渡します。環境によってはダブルクオート(`""`)で囲う必要があるので注意して下さい。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=doargs.sh"></script>


### namespace(名前空間)

似たようなタスクをまとめたい時は、namespace(名前空間)を定義します。たとえば次のように、計算に関連するタスクを`namespace :math`の`do...end`ブロックにまとめてみましょう。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=namespace.rb"></script>

namespace付きで定義したタスクを実行するには、`math:square`のようにコロンでnamespaceを区切って指定します。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=donamespace.sh"></script>


### descでタスクに説明をつける

タスクが増えて来ると、どんなタスクが使えるのか一覧で見たくなります。そんなときに便利なのが`desc`と`rake -T`です。

今まで定義した`:hello`, `math:square`, `math:cube`の1行上に、`desc` メソッドと説明文を追加します。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=desc.rb"></script>

このdesc文はコメント代わりにコードの理解を助けてくれるばかりでなく、`rake -T`を実行すると、次のようにタスク名とその説明を一覧表示してくれます。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=dodesc.sh"></script>


[次のページ](/gm/gc/439680/3/)では、ディレクトリやファイルを扱うrakeのユーティリティメソッドを紹介します。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### file

`file 'hoge.txt' do...end`という形でタスクを定義すると、「`hoge.txt`が存在しない時のみ実行されるタスク」とみなされます。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=file.rb"></script>


<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=dofile.sh"></script>



### directory

`directory`タスクは、指定したディレクトリを作成します。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=dir.rb"></script>

出力からも分かる通り、`mkdir -p`を実行した場合と同じです。

<script src="https://gist.github.com/memerelics/a86b9799ae60eb1deec6.js?file=dodir.sh"></script>


詳しくは[Rakefileの公式ドキュメントはGithubに置いてある](https://github.com/jimweirich/rake/blob/master/doc/rakefile.rdoc)ので、疑問が出たら参照すると良いでしょう。

Rakeの紹介と使い方は以上です。Rubyがまだ若い頃からあるツールなのでやや古臭い部分はありますが、普段の手作業を自動化するときに便利なので是非使ってみてください。

