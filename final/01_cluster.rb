
require 'set'

class Finder
  def initialize(m, n, set)
    @m, @n, @set = m, n, set
    @visited = Set.new
  end
  def each
    (0...@m).each do |i|
      (0...@n).each do |j|
        yield i, j
      end
    end
  end
  def dfs(point, count = 0)
    return 0 if @visited.include?(point)
    return 0 unless @set.include?(point)
    i, j = point
    return 0 if i < 0
    return 0 if j < 0
    return 0 if i >= @m
    return 0 if j >= @n
    @visited << point
    return (
      dfs([point[0] + 1, point[1]]) +
      dfs([point[0] - 1, point[1]]) +
      dfs([point[0], point[1] + 1]) +
      dfs([point[0], point[1] - 1]) +
      1
    )
  end
  def find
    unvisited = to_enum.find { |point| @set.include?(point) && !@visited.include?(point) }
    return nil unless unvisited
    dfs(unvisited)
  end
end

gets.to_i.times do
  m, n = gets.split.map(&:to_i)
  set = Set.new
  gets.to_i.times do
    i, j = gets.split.map(&:to_i)
    set << [i, j]
  end
  finder = Finder.new(m, n, set)
  max = 0
  while (x = finder.find)
    max = [max, x].max
  end
  puts max
end
