#!/usr/bin/ruby

require 'time'

MIDNIGHT = Time.parse("12:00am")
ENDNIGHT = Time.parse("11:59:59,999999pm")
NOON = Time.parse("12:00pm")

# for testing, pull the source data from a file...
if ARGV.length != 1
  puts "Please specify a file to read time data from... "
  exit
else
  begin
    times = IO.readlines(ARGV[0])
  rescue => FOPEN_ERR
    puts "Error reading source file: #{FOPEN_ERR}"
    FOPEN_ERR
  end
end

offsets = []
times.each do |time|
  t = Time.parse(time)
  if t < NOON
    offsets << t-MIDNIGHT
  else
    offsets << t-ENDNIGHT
  end
end

puts offsets
puts "--------"

sum = 0;
offsets.each do |o|
  sum += o
end

mean = sum / offsets.size

puts mean

if mean > 0
  puts MIDNIGHT + mean
else
  puts ENDNIGHT + mean
end
