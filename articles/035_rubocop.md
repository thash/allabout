Ruby の魅力の 1 つは表現の自由度であり、同じ処理を実現するコードをいろいろな方法で書くことができます。しかし裏を返すと、チームで規模の大きな開発をする場合などは個々人の好みがコードに色濃く出てしまい、メンテナンス性や可読性が落ちてしまうという問題も引き起こします。

解決策のひとつは「コーディング規約を作成し、それに従ってプログラムを書く」というものですが、いくらきっちり規約を決めても人間の作業にはミスや抜けが発生しますし、規約を意識しながらコードを修正するのも注意力の無駄です。

このようなケースで、今回紹介する Rubocop が役に立ちます。Rubocop は静的コード解析ツールで、Ruby コードがあらかじめ定義したコーディング規約に従っているかどうかをチェックしてくれます。


### Rubocop のインストールと実行

それでは実際にインストールしてみましょう。Gemfile に rubocop gem を記述して `bundle install` を実行します。

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=Gemfile"></script>

すると 'rubocop' コマンドが使えるようになるので、適当なファイルを作成して、

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=first.rb"></script>

これをテストしてみます。

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=first.sh"></script>

実行する面では問題なく動きますが、rubocop コマンドをかけてみると 2 件警告が出ています。詳しく見てみると、1 件目は

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=first-1.sh"></script>

`Prefer {...} over do...end for single-line blocks.` とあるように「1 行のブロックは do...end じゃなくて{...}で書いたほうが良いよ」という警告のようです。また、2 件目は

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=first-2.sh"></script>

`Space around operator ** detected.` と出ていることから、`**` 演算子の前後にはスペースを開けないというコーディング規約に則った警告のようです。これら 2 件の警告に従ってコードを修正してみます。

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=first_fixed.rb"></script>

再度実行してみると、`no offenses detected` となり無事コーディング規約を満たしていることが確認できます。

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=first_fixed.sh"></script>

Rubocop の役割と基本的な使い方は以上のとおりです。[次のページ](/gm/gc/457015/2/)では、コーディング規約をチームの方針に従ってカスタマイズする方法を紹介します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>


Rubocop は、標準で "[Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)" に準拠しているかどうかをチェックします。

> This Ruby style guide recommends best practices so that real-world Ruby programmers can write code that can be maintained by other real-world Ruby programmers.
>
> [bbatsov/ruby-style-guide](https://github.com/bbatsov/ruby-style-guide)

Ruby Style Guide は概ね理にかなった規約を揃えていますが、組織・チームによってコーディング規約は異なってきます。規約の利用/無視を指定する設定ファイルが `.rubocop.yml` です。 `.rubocop.yml` の中で、前ページで警告された

* `Prefer {...} over do...end for single-line blocks.`
* `Space around operator ** detected.`

の 2 件を無視するようにしてみましょう。

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=cat-rubocop.yml.sh"></script>

先ほど出力されていた警告が出なくなりました。デフォルトで有効化されている他の規約(= Cops)は [rubocop/enabled.yml at master -  bbatsov/rubocop](https://github.com/bbatsov/rubocop/blob/master/config/enabled.yml) で確認することが出来ます。


[最後のページ](/gm/gc/457015/3/)では、既存のプロジェクトに Rubocop を導入する際に便利な `--auto-gen-config` オプションを紹介します。

<div style="page-break-after: always;"><span style="DISPLAY:none">&nbsp;</span></div>

### まずは auto-gen で既存のコードを正とする

既存プロジェクトに Rubocop を導入する際に考えられるのが、歴史あるコードに対して rubocop を実行すると offenses が大量に出て来るため導入ハードルが高く断念する、というケースです。そんなときは `--auto-gen-config` オプションを利用すると作業の取っ掛かりとなります。

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=auto-gen.sh"></script>

`rubocop --auto-gen-config` を実行すると、現時点でコーディング規約違反となった "Cops" をすべて許可する`.rubocop_todo.yml` が生成されます。

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=.rubocop_todo.yml"></script>

これを `.rubocop.yml` から `inherit_from` で参照することで反映されます。

<script src="https://gist.github.com/memerelics/1230d1e4a9e9158b41cf.js?file=.rubocop.yml"></script>

以上の操作で「とりあえず現状動いているコードを正とする」ことができたので、あとは着手しやすい項目から `.rubocop_todo.yml` をひとつひとつ `Enabled: true` に変えていき、コーディング規約に準拠させていくことになります。


### 以上

Rubocop の紹介は以上です。ここまでの例では毎回 `rubocop` コマンドを実行していましたが、お気に入りのエディタと連携する設定を行えば、書いているそばから規約への準拠を促してくれて、とても楽に開発ができます。詳しくは [Editor Integration - bbatsov/rubocop](https://github.com/bbatsov/rubocop#editor-integration) を参照してください。
