# for I in review/*.txt; do ruby -E utf-8 censor.rb "$I"; done
rude = File.read('rude-words.txt').lines.map(&:strip).sort_by(&:length).reverse

data = File.read(ARGV[0])
out = data.dup

rude.each do |word|
  out.gsub!(word, ''.ljust(word.length, '#]!(&@%?'))
end

if out != data
  File.write("review_out/censored-#{File.basename(ARGV[0])}", out)
else
  puts "SKIP"
end
