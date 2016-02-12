def cont? x, y
  if x.is_a? Range
    y == x.end + 1
  else
    y == x + 1
  end
end

def succ x, y
  if x.is_a? Range
    (x.begin..y)
  else
    (x..y)
  end
end

gets.to_i.times do
  data = gets.split[1..-1].map(&:to_i).sort
  out = [ ]
  data.each do |x|
    if out.length > 0 && cont?(out[-1], x)
      out[-1] = succ(out[-1], x)
    else
      out << x
    end
  end
  puts out.map { |x| x.is_a?(Range) ? "#{x.begin}->#{x.end}" : x }.join(',')
end
