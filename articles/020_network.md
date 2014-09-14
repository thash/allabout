今回の記事では、Rubyを使った基礎的なネットワーク通信について解説します。


### TCPによる通信

インターネット上で行われる通信のほとんどはTCPというプロトコル (お互いこの方法でやりとりしましょう, という取り決め) のもと行われています。ウェブページを閲覧する際使われるHTTPも、サーバにログインする際使われるSSHも、TCPの上に実装されているプロトコルです。

TCPには通信の信頼性を上げるための仕組みが組み込まれています。たとえば通信中にデータが失われたり連続して送ったデータが受け取り側で順番が狂ってしまったり、といった事態が発生する可能性があります。そういった時に適切な順序に並び替えたり「失敗したからさっきのもう一回送って」とリクエストしてくれるのがTCPプロトコルです。

RubyからTCP通信を行う基板となるクラスは`TCPSocket`です。`TCPSocket`を継承した`TCPServer`クラスが用意されているので、これを使ってまずはTCP通信を受け取るサーバを作ってみましょう。


### TCPサーバ

<script src="https://gist.github.com/memerelics/7c131d18bc4270a6d33d.js?file=server.rb"></script>

2000番ポートでTCPServerを作成した後、loopを開始して`TCPServer#accept`メソッドで接続を待ちます。相手が接続して来たら、`TCPServer#accept`は相手のsocketを返します。あとはそのsocketからデータが送られてくるのを待ち(`IO#gets`)、送られてきたデータに「:D」を付けてそのまま返すプログラムです。

このサーバに対してtelnetで接続して対話してみます。

<script src="https://gist.github.com/memerelics/7c131d18bc4270a6d33d.js?file=telnet.sh"></script>

「hoge」はtelnet側から入力した文字列、その下の「hoge :D」がサーバから帰ってきた文字列です。想定通り動いていることがわかります。

telnetコマンドを使っても十分役割は果たせるのですが、せっかくなので[次のページ](/gm/gc/446906/2/)ではクライアント側もRubyで作成してみましょう。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### TCPクライアント

<script src="https://gist.github.com/memerelics/7c131d18bc4270a6d33d.js?file=client.rb"></script>

まず引数でホストとポートを指定してサーバが待ち受けているソケットを開き、標準入力からユーザが入力した文字列をsocket(つまりサーバ)に送信、最後にsocketから送られてきたデータを表示するプログラム... つまりは低機能な自作telnetです。実際に使ってみます。

<script src="https://gist.github.com/memerelics/7c131d18bc4270a6d33d.js?file=client.sh"></script>

telnetを使った時と同じように動作しています。ちなみに、TCPSocketクラスはFileクラスと同じくIOクラスを継承しており、

<script src="https://gist.github.com/memerelics/7c131d18bc4270a6d33d.js?file=ancestors.rb"></script>

`IO#puts`や`IO#gets`メソッドが使えるのはこのためです。

ここまででTCPによる通信の基礎を抑えたので、[次のページ](/gm/gc/446906/3/)では少し実世界に足を踏み入れて、自作クライアントでHTTPサーバと会話してみます。

<div style="page-break-after: always"><span style="display: none">&nbsp;</span></div>


### HTTPプロトコルを実装する

最初に言及したように、数多くのプロトコルはTCPを基盤としています。実際にTCPSocketを使って、HTTP通信(と言ってもGETだけですが)を行うプログラムを書いてみましょう。

<script src="https://gist.github.com/memerelics/7c131d18bc4270a6d33d.js?file=http.rb"></script>

このプログラムは、`$ ruby http.rb http://allabout.co.jp/gm/gc/446050/` と引数にURLを渡して使います。URL文字列のパースに便利なURIライブラリを使用しています。

hostに目的となるサーバ、portには80(httpsの場合443)を渡してTCPSocketをnewし、あとはHTTPの取り決めに従い、`GET <パス> HTTP/1.0` と `Host: <ホスト>`を送信して最後に`\r\n\r\n`を送っています。これでsocketにはサーバからの返信が返ってくるという流れです。実際に流してみましょう。

<script src="https://gist.github.com/memerelics/7c131d18bc4270a6d33d.js?file=http.sh"></script>

渡したURLのhtmlが帰ってきているのがわかります。

もちろん実際にRubyでHTTPを扱う場合にTCPSocketを直接使うことはなく、`Net::HTTP`か、さらに抽象度が高いレイヤーのライブラリを使用します。

今回の記事はここまでとしますが、Rubyでウェブページを扱う部分はいずれ記事でも取り上げる予定です。
