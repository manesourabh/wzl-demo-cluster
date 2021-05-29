require 'csv'
i=0
CSV.foreach('../matches_sm.csv', headers: true) do |r|
  i = i + 1
  puts r.to_h
  Match.create(r.to_h)
end
puts "lines in given file " + i.to_s
