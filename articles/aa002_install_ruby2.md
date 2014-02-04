<!--- タイトル（ショート）: Rubyのインストール--->
<!--- タイトル: Rubyのインストール （rbenvを使った方法）--->
<!--- 要約文: rbenvを使ってRuby2.0.0をインストールします。また、rbenvでバージョンを切り替えて複数バージョンを使い分ける方法も紹介します。--->
<!--- Meta Keyword: Ruby 使い方 インストール install rbenv ruby-guild MRI バージョン--->


Rubyのインストールにはいろいろと方法がありますが、ここでは[rbenv](https://github.com/sstephenson/rbenv)を使った方法を紹介します。

なおrbenvに似たツールとして[RVM](http://rvm.io/)も代表的な選択肢ですが、私の周辺では関連機能が"全部盛り"になっているRVMよりも、シンプルなrbenvを好む人が多い印象を受けます。本記事でもrbenvを使ってRubyをインストールする方法を説明していきます。


### rbenvのインストール

rbenvの[README](https://github.com/sstephenson/rbenv/blob/master/README.md) にインストール方法が書かれているので、それに従ってGitHubからダウンロードして~/.rbenvに配置します。

<!---    $ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv--->
<!---    $ edit ~/.bash_profile # zsh使いの場合は~/.zshrc--->
<!---    + export PATH="$HOME/.rbenv/bin:$PATH"--->
<!---    + eval $(rbenv init -) --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-01.sh"></script>

その後、以下のようにしてrbenvコマンドが使えるようになっていることを確認します。

<!---     $ type rbenv --->
<!---     #=> "rbenv is a function" --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-02.sh"></script>

"rbenv is a function" の表示が出ればrbenvのインストールは完了です。


### ruby-buildのインストール

RVMはバージョン管理機能とインストール機能が一体になっているのですが、rbenvが提供するのはあくまでバージョンスイッチ機能だけです。そのため、Rubyのインストールは別途手でソースからビルドしてrbenv管理下に配置するか、もしくはruby-buildというスクリプトを使うことになります。ここでは設定のラクなruby-buildを使う方針で進めます。

<!---     $ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-03.sh"></script>

先ほどcloneしたrbenvディレクトリの下にpluginとしてruby-buildを入れます。こうすることで、`rbenv install`というrbenvのサブコマンドが使えるようになります。


ちなみにMacで[HomeBrew](http://brew.sh/)を使っている人は、rbenvとruby-buidをそれぞれ

<!---     $ brew install rbenv --->
<!---     $ brew install ruby-build --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-14.sh"></script>

としてもインストールすることができます。


これで準備が整ったので、[次のページ](/gm/gc/431930/2/)では実際にRubyをインストールしていきます。

-------------------

### Ruby2.0.0のインストール

まずは先ほどのrbenvを使って `rbenv install --list` を実行してみると、現在利用可能なRubyバージョン一覧が表示されます。

<!---     $ rbenv install --list --->
<!---     Available versions: --->
<!---     ... --->
<!---     1.9.3-p0 --->
<!---     ... --->
<!---     1.9.3-rc1 --->
<!---     2.0.0-dev --->
<!---     2.0.0-p0 --->
<!---     2.0.0-p195 --->
<!---     2.0.0-p247 --->
<!---     2.0.0-p353 --->
<!---     2.0.0-preview1 --->
<!---     2.0.0-preview2 --->
<!---     2.0.0-rc1 --->
<!---     2.0.0-rc2 --->
<!---     2.1.0 --->
<!---     2.1.0-dev --->
<!---     2.1.0-preview1 --->
<!---     2.1.0-preview2 --->
<!---     2.1.0-rc1 --->
<!---     2.2.0-dev --->
<!---     jruby-1.7.8 --->
<!---     jruby-1.7.9 --->
<!---     ... --->
<!---     ree-1.8.7-2012.02 --->
<!---     topaz-dev --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-04.sh"></script>

ずいぶんたくさん選択肢が出てきました。

やや余談ですが、Rubyという言語にもいろいろな実装があります。一番有名かつスタンダードなものがC言語で書かれたMatz氏による"MRI"で、「1.9.3-p448」や「2.0.0-p353」のようにバージョン番号から始まるものがこれに該当します。他にもJavaで実装されてJVM上で動くJRuby、組み込みシステム向けのmrubyなどがありますが説明は割愛します。


それでは、MRIの2.0.0系最新安定バージョンをインストールします。執筆時点では2.0.0-p353ですが、現時点の最新版は[公式ページ](https://www.ruby-lang.org/ja/downloads/)を確認して下さい。

<!---     $ rbenv install 2.0.0-p353 --->
<!---     ... --->
<!---     Installed ruby-2.0.0-p353 to /home/vagrant/.rbenv/versions/2.0.0-p353 --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-05.sh"></script>

Ruby 2.0.0-p353がインストールされました。さっそく使い始めたい人は、

<!---     $ echo "2.0.0-p353" > ~/.ruby-version --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-06.sh"></script>

などとしてシェルを再起動すれば、インストールした最新のRubyを使えるようになります（ruby-versionファイルについては後述）。

<!---     $ ruby -v --->
<!---     ruby 2.0.0p353 (2013-11-22 revision 43784) [x86_64-linux] --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-07.sh"></script>

「とりあえずRubyがインストールできれば良い」という方はここまで読んでいただければ大丈夫です。[次のページ](/gm/gc/431930/3/)では、rbenvがどのようなしくみでRubyのバージョンを切り替えるのかを説明します。

---------------------------

### rbenvによる利用バージョンの切り替え

さて、ここまででバージョンを指定してRubyをインストールする方法がわかりました。

rbenvを使うと、Rubyの複数バージョンを簡単に使い分けることができます。例えば仕事は安定版、プライベート開発は最新版のRubyを利用するなどという使い方も可能です。

<!---     $ rbenv versions --->
<!---     * system (set by /home/vagrant/.rbenv/version) --->
<!---     2.0.0-p353 --->
<!---     2.1.0 --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-09.sh"></script>

現在インストール済のRubyバージョン一覧を見るには`rbenv versions`を使います。前ページで設定した.ruby-versionファイルが存在しない時は以下のようになります。

<!---     $ tree -L 2 ~/.rbenv/versions --->
<!---     ├── 2.0.0-p353 --->
<!---     │   ├── bin --->
<!---     │   ├── include --->
<!---     │   ├── lib --->
<!---     │   └── share --->
<!---     └── 2.1.0 --->
<!---     ├── bin --->
<!---     ├── include --->
<!---     ├── lib --->
<!---     └── share --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-08.sh"></script>

ruby-buildを使ってインストールしたバージョンではなく、システムのRubyが使われていることがわかります。

.ruby-versionというファイルに目的のバージョンを書くことで使うRubyのバージョンを切り替えます。この時、rbenvは「.ruby-versionファイルを探してカレントディレクトリから上に辿って行き、最初に見つかったバージョンを使う」という挙動をします。

例えば次のようなフォルダ構成になっている場合、

<!---     . --->
<!---     ├── .ruby-version // 2.0.0-p353 --->
<!---     └── work --->
<!---     ├── projectA --->
<!---     │   └── .ruby-version // 2.1.0 --->
<!---     └── projectX --->
<!---     │ └── .ruby-version // system --->
<!---     └── projectC --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-10.sh"></script>

projectAでは2.1.0、projectXではsystemのRuby、projectC直下には.ruby-versionが存在しないため、上に辿って初めて見つかる2.0.0-p353が使われることになります。これにより、簡単にプロジェクトごとに別のRubyバージョンを使用することができます。

またRBENV_VERSIONという環境変数を設定すれば、.ruby-versionファイルよりも優先されます。

<!---     $ ruby -v --->
<!---     ruby 1.8.7 (2011-06-30 patchlevel 352) [x86_64-linux] --->
<!---  --->
<!---     $ export RBENV_VERSION=2.0.0-p353 && ruby -v --->
<!---     ruby 2.0.0p353 (2013-11-22 revision 43784) [x86_64-linux] --->

<script src="https://gist.github.com/memerelics/6ac4a7e8841ad6dc8f9a.js?file=aa001-11.sh"></script>

今回の記事は以上です。

Rubyコミュニティは執拗なまでにツールに拘り、不便なところはどんどん新しい解決策が登場してくる文化があるので、ここに書かれた内容もすぐ古くなるかもしれません。その場合は、追加記事の形でフォローしたいと思います。
