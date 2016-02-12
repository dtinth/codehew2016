
require 'csv'
require 'descriptive_statistics'

users = { }
class Person
  attr_reader :id
  def initialize(id)
    @id = id
    @ratings = [ ]
  end
  def review!(stars)
    @ratings << stars
  end
  def significant?
    @ratings.length > 10
  end
  def standard_deviation
    @standard_deviation ||= @ratings.standard_deviation
  end
end

CSV.table('sd/reviews.csv').each do |review|
  reviewer = users[review[:reviewer_id]] ||= Person.new(review[:reviewer_id])
  reviewer.review!(review[:rating])
end

most_variance = users.values.select(&:significant?).max_by(&:standard_deviation)

puts most_variance.id
puts "%.4f" % most_variance.standard_deviation
