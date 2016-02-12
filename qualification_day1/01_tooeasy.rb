puts gets.to_i.times.map { gets.to_i }.map { |n| n % 3 == 0 || n % 7 == 0 ? "hard" : "t#{'o' * n} easy" }
