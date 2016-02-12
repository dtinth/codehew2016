require 'set'
gets.to_i.times do
  m, n = gets.split.map(&:to_i)
  sets = m.times.map { Set[*gets.split.map(&:to_i)[0..-2]] }
  puts (1..m).find { |c| sets.combination(c).any? { |a| a.reduce(&:|).length == n } }
end
