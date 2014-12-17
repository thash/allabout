class Problem < Struct.new(:id, :title, :solved)
  def url
    'https://projecteuler.net/problem=' + id.to_s
  end
end

rows = s.all('#problems_table > tbody > tr').drop(1) # dropでヘッダー行を取り除く

# テーブルの情報を元に各行からProblemインスタンスを生成
problems = rows.map do |row|
  cells = row.all('td')
  Problem.new(*[cells[0].text.to_i, cells[1].text, cells[3].text.length > 0])
end

problems.take(4)
# => [#<struct Problem id=1, title="Multiples of 3 and 5",       solved=true>,
#     #<struct Problem id=2, title="Even Fibonacci numbers",     solved=true>,
#     #<struct Problem id=3, title="Largest prime factor",       solved=false>,
#     #<struct Problem id=4, title="Largest palindrome product", solved=false>]

# まだ解いてない問題をひとつ選び、問題ページを開く
problem = problems.select{|p| !p.solved }.first

s.visit problem.url
