### OAuth 2.0 の仕組み

OAuth 2.0 は認可 (Authorization) の標準仕様として有志の手により策定されているオープンなプロトコルです。OAuth 2.0 を利用すると、ユーザはサードパーティ制アプリケーションにパスワードなど秘密情報を渡すことなく、限定されたアクセス権を与えることができます。

サードパーティ制アプリケーションで Google, Facebook, Twitter など(プロバイダと呼ばれます)を使ったログイン機能を提供するために使われることもありますが、OAuth 2.0 自体は利用者の本人確認を他のプロバイダに任せており、ユーザを認証済みと信頼してアクセス権を与える仕組みです。認証と認可には次のような違いがあります。

- 認証: 本人であることを証明し、検証者がそれを認める (e.g. OpenID, Email+パスワード)
- 認可: 認証済の利用者に対して限定されたアクセス権を与える (e.g. OAuth 2.0)

OAuth 2.0 は 2012 年 10 月に発行された RFC 6749 にて規定されています。

- [RFC 6749 - The OAuth 2.0 Authorization Framework](https://tools.ietf.org/html/rfc6749)
- (日本語訳) [The OAuth 2.0 Authorization Framework](http://openid-foundation-japan.github.io/rfc6749.ja.html)

2009 年に生まれた OAuth 1.0 も、セキュリティ問題を修正されバージョン 1.0a として未だ現役で使われていますが、今回の記事では OAuth 2.0 のみを対象としています。


### OAuth 2.0 とリソース

まず、役者は次の通りです。

- リソースオーナー (e.g. 山田太郎という個人)
- サービスプロバイダ (e.g. Google, Twitter)
- クライアント (サードパーティ制アプリケーション)

「リソースオーナー」という単語には馴染みの薄い人が多いと思います(私もそうです)が、「ユーザ」を「Google や Twitter といったサービスプロバイダに保存されているリソース(投稿した文章など)の所有者(owner)」として言及する際の呼び名と考えると、意味を捉えやすいかもしれません。

「OAuth 2.0 が認証ではない」ということはつまり、サービスプロバイダ側で認証済であれば、例えクライアントを操作する人間がリソースオーナーとは別人であっても OAuth 2.0 には「本人でないこと」を検知しアクセスを拒否する手段がない、ということです。


### グラント種別

OAuth 2.0 を実現する場合、4 個のグラント種別(Grant Type)からひとつを選択します。

1. Authorization Code (認可コード)
2. Implicit Grant
3. Password Credential Grant
4. Client Credential Grant

今回は最もシンプルであり、IPA が「最も無難」であるとする (1) の "Authorization Code" を利用します。

> 結局のところ、Authorization Codeグラント種別を用いるのが最も無難である。
>
> [IPA セキュア・プログラミング講座：Webアプリケーション編](https://www.ipa.go.jp/security/awareness/vendor/programmingv2/web.html)

なお上の IPA セキュア・プログラミング講座では OAuth 2.0 に限らず Web アプリケーションを実装する上でのセキュリティがわかりやすく解説されており、一読するといろいろと得るものがあります。


### OAuth 2.0 の流れ

OAuth 2.0 の全体の流れは次のように規定されています。

<script src="https://gist.github.com/memerelics/947c92c0b8169dde24f1.js?file=abstract-flow.txt"></script>

※ [The OAuth 2.0 Authorization Framework](http://openid-foundation-japan.github.io/rfc6749.ja.html) より

Resource Owner と Client は先に出てきました。Authorization Server と Resource Server はひとまとまりで「サービスプロバイダ」と見たほうがわかりやすいかもしれません。OAuth 2.0 の仕様上、サービスの認可サーバとリソースを吐き出すサーバを分離することが可能であるためこのように書かれています。

上図はクライアントを中心として書かれていますが、これを左からリソースオーナー(ユーザ自身)、クライアント(ユーザの代わりにリクエストを行う代理人)、サービスプロバイダ(Authorization + Resource Server)の三者に並べ直してみると次のように描けます。

<div class="center400 article_image_box"><a title="oauth2" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/457097/oauth2.png"><img width="363" height="300" class="article_image" alt="oauth2" src="//img2.allabout.co.jp/gm/article/457097/oauth2.png" /></a>
</div>

1. クライアントはリソースへアクセスする認可を得たいので、リソースオーナーに「プロバイダから Authorization Code を入手してくれ」とお願いします。
2. リソースオーナーはサービスプロバイダに本人であることを(パスワード等で)証明し、ログインを実行します
3. 認証が成功します
4. 続けてリソースオーナーはサービスプロバイダに対して「このリストにある情報をクライアントにアクセスする許可を与えたい」と意思表示します
5. サービスプロバイダは許諾の意思表示を受け、Authorization Code をリソースオーナーに返します
6. リソースオーナーは入手した Authorization Code をクライアントに渡します
7. クライアントはリソースオーナーの許諾を受けた証拠である Authorization Code をサービスプロバイダに提示します
8. クライアントはサービスプロバイダよりアクセストークンを受け取ります
9. 以降、クライアントはアクセストークンを使うことでリソースオーナーに代わり限定されたサービスを利用することが出来ます。


それでは、実際にここまでの OAuth 2.0 認可フローを Ruby コードに落としこんで行こうと思いますが、まずリソースオーナーは人間(の操作するブラウザ)なので、AllAbout Ruby ガイドの記事として取り上げるべき箇所はさほどありません。

また、あなたがもし何らかの Web サービスを提供しておりユーザのリソースを預かっている場合は「クライアントに対して認可を与えるサービスプロバイダ部分」を実装することもあります。
しかしここを独自実装する必要がある人は少数派で、大抵の人が OAuth 2.0 に触れるときは既存のサービスプロバイダに対してクライアントを実装するケースだと思います。そこで、本記事の残りの部分では Ruby を使ってクライアント骨格部分の処理を書いてみます。

OAuth 2.0 プロトコルのクライアント処理を担う gem は既に作成されており、必要なパラメータを埋めるだけで比較的簡単にアクセストークンの取得まで辿り着くことができます。

[次のページ](/gm/gc/457097/2/)では OAuth 2.0 の実例として、Ruby の oauth2 gem を使って Google APIs を利用してみます。

::allabout-break::


### Google 側の準備

Google APIs を利用するにあたり、前もってサービスプロバイダ (= Google) 側でクライアントの登録が必要です。以下の Google Developers Console から作業します。

[Google Developers Console](https://console.developers.google.com/project)

- 手順(1). Create Project から新規プロジェクト "MyProject" を作成
- 手順(2). "APIs & auth > APIs" を選択。Gmail, Calendar など様々な API が並んでおり必要なものを Enable 可能ですが、今回は例として Drive API を使ってみます。

<div class="center300 article_image_box"><a title="apis" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/457097/apis.png"><img width="300" height="385" class="article_image" alt="apis" src="//img2.allabout.co.jp/gm/article/457097/apis.png" /></a>
</div>

- 手順(3). "APIs & auth > Credentials" を選択、Create New Client ID から新しいクライアントを以下のパラメータで登録します。今回は開発段階としてローカルでクライアント(Rubyプログラム)を動かすためlocalhostの適当なポートを指定しています。
  - Application type = "Web application"
  - Redirect URIs = "http://localhost:8080/oauth2callback"
  - JavaScript origins = "http://localhost:8080"

<div class="center400 article_image_box"><a title="cred" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/457097/cred.png"><img width="400" height="152" class="article_image" alt="cred" src="//img2.allabout.co.jp/gm/article/457097/cred.png" /></a>
</div>

- 手順(4). クライアントが登録できたら、"Download JSON" ボタンからクライアント実装に必要となるデータを入手します。次のようなJSONが落ちてきます(一部置換していますが)。

<script src="https://gist.github.com/memerelics/947c92c0b8169dde24f1.js?file=cred.json"></script>

それではこれを使って OAuth 2.0 認可フローを Ruby で進めて行きます。とりあえずの目標は Google Drive のデータにアクセスすることです。


### oauth2 と signet について

まず Google APIs における OAuth 2.0 利用情報は以下の公式ドキュメントに詳しく記載されています。

[Using OAuth 2.0 to Access Google APIs | Google Identity Platform | Google Developers](https://developers.google.com/identity/protocols/OAuth2)

Ruby で OAuth 2.0 を使う際にデファクトスタンダードとなっているのが、以下の oauth2 gem です。前述の 4 Grant Types に対応しているほか、入手したアクセストークンを付与してリソースを取得するリクエスト部分もサポートしてくれます。

[intridea/oauth2](https://github.com/intridea/oauth2)

実のところ、Google APIs に限っては Google が独自に実装した [signet](https://github.com/google/signet) という gem が存在しており、Google APIs 機能と OAuth 2.0 認可が統合されているため Google はこちらを使うことを推奨しています。

[OAuth 2.0 | API Client Library for Ruby (Alpha) | Google Developers](https://developers.google.com/api-client-library/ruby/guide/aaa_oauth)

しかし本記事では解説に汎用性を持たせるため、signet ではなく oauth2 の方を利用していますのでご了承ください。


[最後のページ](/gm/gc/457097/3/)では Google APIs のアクセストークンを入手し、Google Drive のファイル一覧を参照する例を示します。

::allabout-break::


### oauth2 gem による認可フロー

まずは`OAuth2::Client.new`でクライアントを生成します。その際に Google 側で登録したクライアントの`client_id`と`client_secret`、その他のパラメータを渡します。

<script src="https://gist.github.com/memerelics/947c92c0b8169dde24f1.js?file=Gemfile"></script>

<script src="https://gist.github.com/memerelics/947c92c0b8169dde24f1.js?file=myclient.rb"></script>

クライアントの生成を単ファイルに切り出しているのは、Authorization Code 取得 URL を出力する部分と Sinatra でリダイレクトを受け取るプロセスの両方から使えるようにするためです。以下に図を再掲します。

<div class="center400 article_image_box"><a title="oauth2" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/457097/oauth2.png"><img width="363" height="300" class="article_image" alt="oauth2" src="//img2.allabout.co.jp/gm/article/457097/oauth2.png" /></a>
</div>

作成した Client を使い、Authorization Code をリクエストします(1)。

<script src="https://gist.github.com/memerelics/947c92c0b8169dde24f1.js?file=get_authorization_code.rb"></script>

出力される URL にブラウザでアクセスすると(2)(この時点で自分自身はリソースオーナーとして振舞っています)、Google アカウントへログインしたあと、下のような画面でリソースへのアクセスを許可するかどうかの確認を求められます(3)。

<div class="center400 article_image_box"><a title="al" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/457097/allow.png"><img width="400" height="235" class="article_image" alt="al" src="//img2.allabout.co.jp/gm/article/457097/allow.png" /></a>
</div>

ここで "Accept" を選ぶと(4)、Authorization Code が発行され(5)、即座にブラウザはクライアントが待ち受けているはずの `redirect_url` へリソースオーナーを導き...

> Firefox can't establish a connection to the server at localhost:8080.

`localhost:8080` で受け付けるプロセスを起動し忘れていました。下のコードを走らせて sinatra を 8080 番ポートで listen させ、もう一度 "Accept" します。

<script src="https://gist.github.com/memerelics/947c92c0b8169dde24f1.js?file=client_sinatra.rb"></script>

今度こそ `https://localhost:8080/oauth2callback` へリダイレクトされます。渡されたパラメータにはAuthorization Code が含まれているので、あとはクライアントだけでサービスプロバイダとやりとりすることができます(7),(8),(9)。


### リソースで遊ぶ - アクセストークンの用例

ここまでの OAuth 2.0 認可フローはどんなサービスでも共通ですが、アクセストークンを得たあとに必要となるリソース API はサービスによって千差万別で、各サービスのドキュメントを参照しながら利用していくことになります。そのため以下の Google Drive API はあくまで利用の一例であることに注意してください。

[Google Drive REST API Overview | Drive REST API| Google Developers](https://developers.google.com/drive/web/about-sdk)

<script src="https://gist.github.com/memerelics/947c92c0b8169dde24f1.js?file=drive.rb"></script>

Google Spreadsheet のデータを Excel 形式で落としてくることができました。

<div class="center400 article_image_box"><a title="xx" rel="allabout-gallery" class="slide_image" href="//img2.allabout.co.jp/gm/article/b/457097/xxx.png"><img width="400" height="191" class="article_image" alt="xx" src="//img2.allabout.co.jp/gm/article/457097/xxx.png" /></a>
</div>

以上で OAuth 2.0 の紹介は終わりです。OAuth 2.0 は広く使われているため便利なライブラリに隠されてしまいがちですが、一度中で何が行われているのかをじっくり追いかけてみると応用が効くようになり、様々なサービスの API で楽しく遊べます。
