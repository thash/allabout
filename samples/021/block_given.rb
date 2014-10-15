def check_block
  if block_given?
    puts 'block!'
    yield
  else
    puts 'no block'
  end
end

check_block # => no block

check_block { puts 'hello from block' }
# => block!
# => hello from block
