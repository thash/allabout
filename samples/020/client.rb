require 'socket'

socket = TCPSocket.open(*ARGV)

while line = STDIN.gets
  socket.puts line
  socket.flush
  puts socket.gets
end

socket.close
