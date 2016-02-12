
Dir.chdir File.dirname(__FILE__)

require_relative './lib.rb'
require 'phashion'

images = get_nd_images
fingerprints = { }

images.each do |image|
  img = Phashion::Image.new(image)
  fingerprints[image] = img.fingerprint
  puts "Fingerprint of #{image} = #{fingerprints[image]}"
end

$store.transaction {
  $store[:fingerprints] = fingerprints
}
