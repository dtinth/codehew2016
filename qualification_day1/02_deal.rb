# utility
class NewDate < Struct.new(:year, :month, :date)
  def day_count
    [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1] + (year % 4 == 0 ? 1 : 0)
  end
  def succ
    return next_month if date == day_count
    NewDate.new(year, month, date + 1)
  end
  def next_year
    NewDate.new(year + 1, 1, 1)
  end
  def next_month
    return next_year if month == 12
    NewDate.new(year, month + 1, 1)
  end
  def diff other
    current = self
    count = 1
    while current != other; count += 1; current = current.succ; end
    count
  end
end

# unit test
raise unless NewDate.new(3000, 01, 01).succ == NewDate.new(3000, 01, 02)
raise unless NewDate.new(3000, 01, 31).succ == NewDate.new(3000, 01, 32)
raise unless NewDate.new(3000, 01, 32).succ == NewDate.new(3000, 02, 01)
raise unless NewDate.new(3000, 12, 32).succ == NewDate.new(3001, 01, 01)
raise unless NewDate.new(3001, 01, 31).succ == NewDate.new(3001, 02, 01)
raise unless NewDate.new(3001, 02, 28).succ == NewDate.new(3001, 03, 01)

# main logic
puts gets.to_i.times
.map { gets.split.map(&:to_i) }
.map { |a, b, c, d, e, f| [NewDate.new(a, b, c), NewDate.new(d, e, f)]}
.map { |x, y| x.diff y }
