env = %w(production staging development invalid-value).sample(1).first

url = if env == 'production'
        'http://api.hogehoge.com/'
      elsif env == 'staging'
        'http://api.hogehoge-stg.com/'
      elsif env == 'development'
        'http://api.local:3000/'
      end

# どの条件にも該当しない時はurlにはnilが入る
puts url
