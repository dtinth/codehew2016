
gets.to_i.times do
  out = [ ]
  gets.to_i.times do
    b, e = gets.split.map(&:to_i)
    out << [b, 1] << [e, -1]
  end
  usage = [ ]
  out.sort_by! { |(a, b)| [a, -b] }
  c = 0
  out.each do |_, n|
    usage << (c += n)
  end
  puts usage.max
end
