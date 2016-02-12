# Encoding: utf-8
require 'csv'

follower_counts = { }

CSV.table('bias/users.csv').each do |row|
  follower_counts[row[:id].to_i] = row[:number_of_followings]
end

reviewed = { }
reviews = [ ]

CSV.table('bias/reviews.csv').each do |review|
  reviews << review
end

reviews.sort_by! { |r| r[:id] }

reviews.each do |review|
  หน้าม้า = (
    !reviewed[review[:reviewer_id].to_i] &&
    review[:rating].to_i == 5 &&
    review[:description].to_s.length <= 100 &&
    follower_counts[review[:reviewer_id].to_i] < 100
  )
  reviewed[review[:reviewer_id].to_i] = true
  p review[:id] if หน้าม้า
  $stderr.puts [
    review[:id],
    reviewed[review[:reviewer_id].to_i],
    review[:rating].to_i,
    review[:description].to_s.length,
    follower_counts[review[:reviewer_id].to_i]
  ].inspect
end
