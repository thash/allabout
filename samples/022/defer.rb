require 'bundler/setup'
Bundler.require

require 'open-uri'

EM.run do
  puts "main: #{Thread.current}"

  operation = -> do
    puts "defer operation: #{Thread.current}"
    open('http://allabout.co.jp/'){|f| f.read.scan(/<title>(.*)<\/title>/) }
  end

  callback  = -> (result) do
    puts "callback: #{Thread.current}"
    puts result
  end

  puts '--- calling defer'
  EM.defer(operation, callback)
  puts '--- called defer'

  EM.stop
end
