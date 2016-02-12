
Dir.chdir File.dirname(__FILE__)

require_relative './lib.rb'

$store.transaction do
  $store[:images] = Dir['images/**/*.bmp'].to_a
end
