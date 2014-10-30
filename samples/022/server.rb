require 'bundler/setup'
Bundler.require

module EchoServer
  def post_init
    puts '-- connection established'
  end

  def receive_data(data)
    send_data ">>> echo: #{data}"
  end
end

EventMachine::run {
  EventMachine::start_server '127.0.0.1', 8081, EchoServer
  puts 'running echo server on 8081'
}
