require 'prime'

13195.prime_division
# => [[5, 1], [7, 1], [13, 1], [29, 1]]

600851475143.prime_division
# => [[71, 1], [839, 1], [1471, 1], [6857, 1]]
600851475143.prime_division.map{|pair| pair.first }.max
# => 6857
