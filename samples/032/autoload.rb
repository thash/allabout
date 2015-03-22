class Shell
end
Shell.autoload :Core, './core' # 同ディレクトリのcore.rbを指す

puts "Core is not loaded yet."

puts Shell::Core.new # Coreが必要になる
# => loading core.rb # ここで初めて読まれる
# => core -- initialized
#<Shell::Core:0x007f89998938c8>
