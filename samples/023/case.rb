env = %w(production staging development invalid-value).sample(1).first

url = case env
      when 'production'  then 'http://api.hogehoge.com/'
      when 'staging'     then 'http://api.hogehoge-stg.com/'
      when 'development' then 'http://api.local:3000/'
      end

puts url
