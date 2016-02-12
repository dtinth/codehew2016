
require 'set'

class Block
  def initialize(n, m, data)
    @n, @m, @data = n, m, data
  end
  def pieces
    @data
  end
  def can_put?(room, i, j)
    return false if i + @n > room.rows
    return false if j + @m > room.columns
    pieces.all? { |k, h| !room.used?(i + k, j + h) }
  end
end

class ExhibitionRoom
  def rows
    @n
  end
  def columns
    @m
  end
  def used?(i, j)
    @used.include?([i, j])
  end
  def initialize(n, m)
    @n, @m = n, m
    @used = Set.new
    @blocks = [
      Block.new(3, 2, [
        [0, 0], [1, 0], [2, 0], [2, 1]
      ]),
      Block.new(3, 2, [
        [0, 0], [0, 1], [1, 1], [2, 1]
      ]),
      Block.new(2, 3, [
        [1, 0], [1, 1], [1, 2], [0, 2]
      ]),
      Block.new(2, 3, [
        [1, 0], [0, 0], [0, 1], [0, 2]
      ]),
    ]
    @count = 0
  end
  def put_block(block, i, j)
    block.pieces.each do |di, dj|
      @used << [i + di, j + dj]
    end
    yield
  ensure
    block.pieces.each do |di, dj|
      @used.delete [i + di, j + dj]
    end
  end
  def count
    @count
  end
  def fit!
    if @used.size == @n * @m
      @count += 1
      return
    end
    (0...@n).each do |i|
      (0...@m).each do |j|
        @blocks.each do |block|
          if block.can_put?(self, i, j)
            put_block(block, i, j) do
              fit!
            end
          end
        end
      end
    end
  end
end

gets.to_i.times do
  rows, columns = gets.split.map(&:to_i)
  room = ExhibitionRoom.new(rows, columns)
  room.fit!
  puts room.count
end
