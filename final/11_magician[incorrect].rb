
count = gets.to_i
rest = $stdin.read.downcase.scan(/.*?finem libri\./i)
raise "Invalid input" if rest.length != count

def lcs(a, b)
  i = 0
  postproc = -> x { a[0...x].strip.length }
  while i < a.length && i < b.length
    return postproc[i] if a[i] != b[i]
    i += 1
  end
  postproc[i]
end

rest.each do |text|
  $stderr.puts text.length
  suffixes = [ ]
  (0...text.length).each do |i|
    suffixes << text[i..-1]
  end
  suffixes.sort!
  p suffixes.each_cons(2).map { |a, b| lcs(a, b) }.max
end
