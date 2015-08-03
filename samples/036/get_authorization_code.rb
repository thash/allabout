require './myclient'

# (1) クライアントがリソースオーナーにサービスプロバイダ窓口 URL を提示する
puts client.auth_code.authorize_url(redirect_uri: cred['redirect_uris'].first,
                                    scope: 'https://www.googleapis.com/auth/drive')

# (2), (3) -- サービスプロバイダ側で認証(ログイン)を行う

# (4) リソースオーナーは URL にアクセスしてクライアントに対して認可を与える。
#     許可フェイズが終わったら、クライアントへリダイレクトさせる
# => https://accounts.google.com/o/oauth2/auth
#    ?client_id=111111111111-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com
#    &redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth2callback
#    &response_type=code
#    &scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive
