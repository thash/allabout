require 'socket'
require 'uri'

# $ ruby http.rb http://allabout.co.jp/gm/gc/446050/

uri = URI(ARGV[0])
# puts uri.host => "allabout.co.jp"
# puts uri.port => 80
# puts uri.path => "/gm/gc/446050/"

socket = TCPSocket.new(uri.host, uri.port)

socket.puts("GET #{uri.path} HTTP/1.0\r\n")
socket.puts("Host: #{uri.host}\r\n")
socket.puts("\r\n")

# socket.read はレスポンス全体でheaderとbodyを含むため, headerだけ切り落としbodyを出力
puts socket.read.split("\r\n\r\n").drop(1)

socket.close
