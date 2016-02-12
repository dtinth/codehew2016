
require 'rgeo'

$factory = RGeo::Geos.factory(native_interface: :ffi)

def to_point data
  x, y = data.split(',').map(&:to_f)
  [x, y]
end
def get_point
  to_point gets
end

def format_point p
  p.map { |v| v.round(7) }.join ','
end

def star_points centre, radius
  rho = Math.sqrt(0.1 * (5 - Math.sqrt(5)))
  r = Math.sqrt(0.1 * (25 - 11 * Math.sqrt(5)))
  (0..10).map { |i|
    rout = i.even? ? radius : radius * r / rho
    radian = i / 10.0 * Math::PI * 2
    [
      centre[0] + rout * Math.sin(radian),
      centre[1] + rout * Math.cos(radian)
    ]
  }
end

centre = get_point
radius = gets.to_f

raw_points = star_points(centre, radius)

# XXX: Extra line is printed, thus making this answer incorrect.
puts raw_points.map { |pt| format_point(pt) }

points = raw_points.map { |x, y| $factory.point(x, y) }
ring = $factory.linear_ring([ *points, points[0] ])
polygon = $factory.polygon(ring)

loop do
  data = gets
  break unless data
  data = data.strip
  break if data.empty?
  x, y = to_point(data)
  puts $factory.point(x, y).within?(polygon) ? "1" : "0"
end
