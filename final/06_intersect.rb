
require 'rgeo'

$factory = RGeo::Geos.factory(native_interface: :ffi)

def get_poly
  points = gets.split(' ').map { |c|
    x, y = c.split(',').map(&:to_f).tap { |a|
      raise "NAW" if a.length != 2
    }
    $factory.point(x, y)
  }
  ring = $factory.linear_ring([ *points, points[0] ])
  poly = $factory.polygon(ring)
end

province = get_poly
district = get_poly
output = province * district

def f v
  if v.round.to_f == v
    v.round
  else
    v.round(7)
  end
end

def ppoints points
  remaining = points.drop(1).reverse
  puts remaining.length
  return unless remaining.length > 0
  start_index = remaining.each_with_index.min_by { |p, i| Math.hypot(p.x, p.y) }.last
  remaining.rotate! start_index
  puts remaining.map { |p|
    "#{f p.x},#{f p.y}"
  }.join(' ')
end

points = output.respond_to?(:exterior_ring) ? output.exterior_ring.points : [ ]
ppoints points
