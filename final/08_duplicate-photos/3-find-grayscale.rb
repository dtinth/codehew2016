
Dir.chdir File.dirname(__FILE__)

require_relative './lib.rb'
require 'rmagick'

images = get_nd_images
hash = { }
duplicates = { }

TMP = '/tmp/test.bmp'

images.each do |image|
  img = Magick::Image::read(image)[0]
  img = img.quantize(256, Magick::GRAYColorspace)
  img.write(TMP)
  md5 = `/usr/local/bin/md5sum #{TMP}`.split.first
  if hash[md5]
    puts "FOUND DUPLICATE"
    duplicates[md5] = [hash[md5], image]
  else
    puts image
    hash[md5] = image
  end
end

$store.transaction {
  $store[:gray] = duplicates.values
}
