

require_relative './lib.rb'

$html = File.open('report.html', 'w')
$report = [ ]
$ban = [
  727,
  822,
  437,
  764,
  643,
  131,
  198,
  98,
  700,
  951,
  281
]

def fileof(a)
  a.scan(/(\d+)\.bmp/i)[0][0].to_i
end

def report(title, stuff)
  $html.puts '<h1>' + title + '</h1>'
  $html.puts '<table>'
  stuff.each do |a, b|
    next if $ban.include?(fileof a)
    next if $ban.include?(fileof b)
    $html.puts '<tr>'
    $html.puts '<td>' + "<img src='#{a}'/>" + '</td>'
    $html.puts '<td>' + "<img src='#{b}'/>" + '</td>'
    $html.puts "<td>#{fileof a} #{fileof b}</td>"
    $html.puts '</tr>'
    $report << [fileof(a), fileof(b)]
  end
  $html.puts '</table>'
end

$store.transaction(true) do
  report 'exact', $store[:exact]
  report 'hamming', $store[:hamming]
end

puts $report.map(&:sort).sort.map { |x| x.join ',' }
