# NOTE: Refactored version
#       Uses Array#reduce instead of imperative code and
#       always use a Range in the reduction array.

def cont? x, y
  y == x.end + 1
end

def succ x, y
  (x.begin..y)
end

gets.to_i.times do
  data = gets.split[1..-1].map(&:to_i).sort
  out = data.reduce [ ] do |a, x|
    if !a.empty? && cont?(a.last, x)
      [*a[0...-1], succ(a.last, x)]
    else
      [*a, x..x]
    end
  end
  puts out.map { |x| x.size > 1 ? "#{x.begin}->#{x.end}" : x.begin }.join(',')
end
