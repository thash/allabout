### Rubyとテストは切り離せない

Rubyとテストの関係は、以下のように記述できます（イメージをつかむため厳密ではない表現をしています）。

書いたとおりに決まった動きをする「硬い」言語とは異なり、Rubyはプログラマに大きな自由を与え、実行時の柔軟な処理を可能とする言語仕様/哲学を持ちます。その副作用として「動くように書いた」コードだけでは実装の正しさを保証できず、部分的に「実行して確認する」必要があります。これがテストです。


本記事はプログラムの「テスト」と呼ばれる中でも、小さな機能単位のみを対象とする「単体テスト(Unit Test)」を主なテーマとしています。

概してRubyプログラマは前述のような言語の特性に自覚的であり、Rubyコミュニティには「テストは必須、あるのが普通」という文化が根付いています。


今回の記事では広く使われているRubyのテストライブラリであるRSpecを取り上げ、インストール方法と基本的な使い方を紹介します。


### RSpecのインストールとセットアップ

[rspec](https://github.com/rspec/rspec) はRuby界隈でよく使われているテストライブラリで、クセはありますが、かなり自然言語(英語)に近い読み心地(?)のDSLを提供するのが特徴です。

rspecはgemとして提供されています。機能ごとにいくつかの子gemに分離されていますが、今回は標準的なセットが含まれた「rspec」gemを使います。

<script src="https://gist.github.com/memerelics/32d01adf8b5e79924ca2.js?file=Gemfile"></script>

<script src="https://gist.github.com/memerelics/32d01adf8b5e79924ca2.js?file=install.sh"></script>

rspec-support, rspec-core, rspec-expectations, rspec-mocks がインストールされます。

ひとつ注意点として、新旧文法の違いがあります。
RSpecは長く使われて来たバージョン2系から3系に上がる際に大きな文法の変更がありました。そのため、ウェブで見つかる記事の少なくない割合は廃止されたバージョン2系の例で書かれており、情報収集の際には注意が必要です。本記事では執筆時(2015年1月27日)における最新バージョン(3.1.0)の文法に基づいた例を示します。


[次のページ](/gm/gc/450896/2/)では、RSpecの基本的な使い方と文法を紹介します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### RSpecの文法

まず公式ページから最初のサンプルを引用します。

<script src="https://gist.github.com/memerelics/32d01adf8b5e79924ca2.js?file=sample.rb"></script>

基本的にRSpecのコードは`describe > it` の階層構造となっており、これにaliasや分岐構造が生えているイメージです。これを自然言語風に直すと

> "Describe an order."
>
> "It sums the prices of its line items."

と、テスト対象コードの実行結果を文章で表しているかのように読み下すことができます。

実行されるテストケースは、 itブロックの中で「予期(expect)する実行結果」と「実際の(actual)実行結果」に対して ` expect(<target>).to <matcher> <actual> ` と書きます。


### matcher

上述のmatcherについて、少し補足説明をします。`expect(...).to` あるいは `expect(...).not_to` のあとには様々なmatcherが利用可能です。

[Built in matchers - RSpec Expectations - RSpec - Relish](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)

上記サイトに詳しいですが、代表的なものをいくつか取り出すと

* expect(actual).to be_truthy
* expect(actual).to be_falsey
* expect(actual).to be_nil
* expect(actual).to be_empty
* expect(actual).to be < 1000
* expect(actual).to eq 1000
* expect(actual).to be > 1000
* expect(actual).to be_a(String)
* expect(actual).to raise_error
* expect(actual).to include(1,2,3)

などがあります。過去バージョンで使われていた`be_true`および`be_false`はそれぞれ`be_truthy`、`be_falsey`に置き換えられていることに注意してください。

他に、expectにブロックを渡して「ブロックの実行が何を変えるか」という`change`マッチャーもあります。

<script src="https://gist.github.com/memerelics/32d01adf8b5e79924ca2.js?file=change.rb"></script>


[次のページ](/gm/gc/450896/3/)ではRSpecを実行する方法を解説します。


<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


### RSpecの実行

以下のようなサンプルのspecファイルを用意します。ファイル名に制約はありませんが、`*_spec.rb` とするのが慣習となっています。

<script src="https://gist.github.com/memerelics/32d01adf8b5e79924ca2.js?file=string_spec.rb"></script>

`rspec`コマンドの引数にspecファイルを渡すことで、テストが実行されます。

<script src="https://gist.github.com/memerelics/32d01adf8b5e79924ca2.js?file=run.sh"></script>

ドットが成功したテストを表し、テストケースが3個でエラーが0個、つまりオールグリーンの状態です。

なお、テストが失敗した場合の出力は以下のとおりです。

<script src="https://gist.github.com/memerelics/32d01adf8b5e79924ca2.js?file=string_spec_err.rb"></script>

<script src="https://gist.github.com/memerelics/32d01adf8b5e79924ca2.js?file=run_err.sh"></script>

失敗箇所とその理由が出力され、これを手がかりにコード(あるいはテストコード)を修正していくのが基本的な作業となります。


### 次回はminitest

RSpecはgemとして提供されていましたが、実はRubyには標準でminitestという軽量なテストライブラリが添付されています。次回の記事ではこれを扱います。
