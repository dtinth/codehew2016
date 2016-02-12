
Dir.chdir File.dirname(__FILE__)

require_relative './lib.rb'
require 'phashion'

images = get_nd_images
fingerprints = $store.transaction(true) { $store[:fingerprints] }
fingerprints

hamming = proc do |a, b|
  aa = fingerprints[a]
  bb = fingerprints[b]
  Phashion.hamming_distance(aa, bb)
end

out = fingerprints.keys.combination(2).select { |a, b|
  hamming[a, b] <= 15
}

p out.length
$store.transaction {
  $store[:hamming] = out.sort_by { |a, b| hamming[a, b] }
}
