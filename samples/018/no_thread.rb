require 'open-uri'

(1..100).each do |i|
  open("./#{i}.png", 'wb') do |f|
    f.write open("http://cambelt.co/200x100/#{i}.png").read
  end
end
