require 'set'

teams_count, employees_count = gets.split.map(&:to_i)
links = { }
teams_count.times do
  gets.to_i.times do
    a, _, *bs = gets.split.map(&:to_i)
    bs.each do |b|
      (links[a] ||= Set.new) << b
    end
  end
end

def bfs links, a, b
  fringe = [ a ]
  length = { a => -1 }
  visited = Set[a]
  until fringe.empty?
    front = fringe.shift
    next unless links[front]
    links[front].each do |t|
      next if visited.include?(t)
      visited << t
      fringe << t
      length[t] = length[front] + 1
    end
  end
  raise if length[b] == -1
  length[b]
end

gets.to_i.times do
  a, b = gets.split.map(&:to_i)
  r = bfs(links, a, b)
  if r.nil?
    puts "no"
  else
    puts r
  end
end
