# NOTE: Refactored version
#       Uses RGL so that I don't have to write the graph algorithms myself.

require 'rgl/adjacency'
require 'rgl/traversal'

teams_count, _ = gets.split.map(&:to_i)
graph = RGL::DirectedAdjacencyGraph[]
teams_count.times do
  gets.to_i.times do
    a, _, *bs = gets.split.map(&:to_i)
    bs.each { |b| graph.add_edge(a, b) }
  end
end

gets.to_i.times do
  a, b = gets.split.map(&:to_i)
  bfs = graph.bfs_iterator(a).attach_distance_map
  if bfs.include?(b)
    puts bfs.distance_to_root(b) - 2
  else
    puts "no"
  end
end
