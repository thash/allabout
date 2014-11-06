n = rand(1000)
n % 15 == 0 ? 'FizzBuzz' : (n % 5 == 0 ? 'Fizz' : (n % 3 == 0 ? 'Buzz' : nil))
