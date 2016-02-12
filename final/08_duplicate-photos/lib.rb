
require 'yaml/store'

$store = YAML::Store.new('store.yaml')

def get_nd_images
  $store.transaction(true) { (
    out = $store[:images] - $store[:exact].flatten
    p "#{out.length} images left out of #{$store[:images].length}"
    out
  ) }
end
