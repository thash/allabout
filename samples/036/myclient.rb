require 'bundler'
Bundler.require

def cred
  @cred ||= JSON.parse(File.open('cred.json').read)['web']
end

def client
  @client ||= OAuth2::Client.new(cred['client_id'], cred['client_secret'],
                                 authorize_url: cred['auth_uri'],
                                 token_url: cred['token_uri'])
end
