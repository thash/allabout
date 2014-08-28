require 'open-uri'

(1..10).each do |i|
  fork do
    open("./#{i}.png", 'wb') do |f|
      f.write open("http://cambelt.co/200x100/#{i}.png").read
    end
  end
end

