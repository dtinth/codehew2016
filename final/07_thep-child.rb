
def bad a
  a = a.reverse
  l = 1
  while 2 * l <= a.length
    if a.take(l) == a.drop(l).take(l)
      $stderr.puts l
      return true
    end
    l += 1
  end
  return false
end

gets.to_i.times do
  gets
  data = gets.split.map(&:to_i)
  puts bad(data) ? 'yes' : 'no'
end
