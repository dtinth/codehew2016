
class Mapping
  def initialize(raw)
    @cache = { }
    @raw = raw
  end
  def count(x, y)
    return 0 if x < 0
    return 0 if y < 0
    @cache[[x, y]] ||= begin
      count(x - 1, y) + count(x, y - 1) - count(x - 1, y - 1) + @raw[[x, y]]
    end
  end
end

gets.to_i.times do
  number_of_restaurants = Hash.new(0)
  n, w, h = gets.split.map(&:to_i)
  $stderr.puts [n, w, h].inspect
  n.times do
    x, y = gets.split.map(&:to_i)
    raise "NO" if x >= w
    raise "NO" if y >= h
    number_of_restaurants[[x, y]] += 1
  end
  mapping = Mapping.new(number_of_restaurants)
  out = 0
  gets.to_i.times do
    x, y, w, h = gets.split.map(&:to_i)
    # XXX: This part has off-by-one error.
    out += (
      mapping.count(x + w, y + h) -
      mapping.count(x - 1, y + h) -
      mapping.count(x + w, y - 1) +
      mapping.count(x - 1, y - 1)
    )
  end
  puts out
end
