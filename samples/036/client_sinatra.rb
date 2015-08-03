require './myclient'
require 'sinatra'

set :port, 8080

get '/oauth2callback' do
  # (5) Authorization Code がパラメータに入ってくる
  puts "code: #{params['code']}"

  # (6), (7) Authorization Code を渡して
  access_token = client.auth_code.get_token(params['code'],
                                            redirect_uri: cred['redirect_uris'].first)

  # (8) Access Token を得る
  puts "token: #{access_token}"

  # (9) Access Token を使ってリソースにアクセスする
  files = access_token.get('https://www.googleapis.com/drive/v2/files').parsed['items']

  "ok"
end
