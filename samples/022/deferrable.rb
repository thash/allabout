require 'bundler/setup'
Bundler.require

class Dice
  include EM::Deferrable
  def throw
    rand(1..6)
  end
end

EM.run do
  dice = Dice.new

  # 成功時の処理を登録
  dice.callback do |n|
    puts "it's odd: #{n}"
  end

  # 失敗時の処理を登録
  dice.errback do |n|
    puts "it's even: #{n}"
  end

  case num = dice.throw
  when 1,3,5
    dice.succeed(num) # diceオブジェクトに成功状態をセット
  when 2,4,6
    dice.fail(num)    # diceオブジェクトに失敗状態をセット
  end

  EM.stop
end
