### EventMachineとは

eventmachineは、Rubyでイベント駆動I/Oや並行処理の機能を提供する低レイヤーなライブラリです。


### 簡単なechoサーバ

まずはgemをインストールします。以下GemfileのようにBundlerを使うか、あるいは単純に`gem install eventmachine`と叩いてください。

<script src="https://gist.github.com/memerelics/fa7e9030f3273d823a86.js?file=Gemfile"></script>

EventMachineを使って簡単なechoサーバを作成します。

<script src="https://gist.github.com/memerelics/fa7e9030f3273d823a86.js?file=server.rb"></script>

前半の`module EchoServer`がサーバの定義、後半の`EventMachine::run`ブロック内が実行本体です。EchoServerには何もincludeせず、おもむろに`post_init`（クライアント接続時に実行される処理）と`receiver_data`（クライアントからデータが送られてきた時に実行される処理）のふたつのメソッドを定義します。

`EventMachone::run`ブロック内で`EventMachine::start_server`を呼び、ホストとポート番号、そして先ほど定義したEchoServerモジュールを渡してやればこれだけでサーバが起動します。

実行ログは以下の通りです。

<script src="https://gist.github.com/memerelics/fa7e9030f3273d823a86.js?file=run_server.sh"></script>

過去の記事、[Rubyによるネットワーク通信の基礎 -Ruby- All About](http://allabout.co.jp/gm/gc/446906/)では似たような処理をTCPServerクラスを直接使って実装したので、比較してみてください。

EventMachineは他にも、`EM.open_keyboard`でユーザのキーボード入力を受け取ることもできます。

[次のページ](/gm/gc/448474/2/)では、`EM.defer`と`EM::Deferrable`を利用してイベント発生のタイミングで処理を実行させる方法を説明します。


<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### EM.defer

`EM.defer`を使うことで、ブロッキングI/O処理(ファイル読み込み、ネットワーク通信など)をメインスレッドの外で実行させ、結果をコールバック関数で受け取ることができます。

以下に例を示します。

<script src="https://gist.github.com/memerelics/fa7e9030f3273d823a86.js?file=defer.rb"></script>

`EM.run`の中で、deferにより別スレッドで実行される`operation`、およびdefer実行が完了した時にメインスレッドで呼ばれる`callback`というふたつのラムダを定義しています。これを実行すると、

<script src="https://gist.github.com/memerelics/fa7e9030f3273d823a86.js?file=run_defer.sh"></script>

`operation`ラムダの内容のみ別スレッドで実行されているのがわかります。


### EM::Deferrable

一方、`EM::Deferrable`はオブジェクトの状態を監視して、処理が成功したか失敗したかによってインスタンスに予め登録したコールバックを呼び出す機能を持ちます。使い方は以下の例を見てください。

<script src="https://gist.github.com/memerelics/fa7e9030f3273d823a86.js?file=deferrable.rb"></script>

まず状態を監視したいクラスに`EM::Deferrable`をincludeすることで、いくつかのメソッドが利用可能になります。成功時の処理を`callback`、失敗時の処理を`errback`というメソッドに渡したブロックの中で定義しておき、あとは処理結果に応じて成功(`succeed`)、失敗(`fail`)のいずれかを呼び出した時点であらかじめ登録しておいた処理が実行されます。

<script src="https://gist.github.com/memerelics/fa7e9030f3273d823a86.js?file=run_deferrable.sh"></script>

これによって、非同期処理の結果に応じて分岐する処理を可読性高く書くことが出来ます。

以上でEventMachineの簡単な紹介は終わりです。
