require 'socket'

server = TCPServer.new 2000

loop do
  # クライアントの接続を待つ
  socket = server.accept  # #<TCPSocket:fd 9> など
  while data = socket.gets
    socket.puts data.chomp + ' :D'
  end
  socket.close
end
