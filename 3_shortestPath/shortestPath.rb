#!/usr/bin/ruby
require 'pp'
require 'lib/node'

INFINITY = 1.0/0

edgeCosts      = {}
totalCostTo    = {}
previous       = {}




# for testing, pull the source data from a file...
if ARGV.length != 1
  puts "Please specify a file to read time data from... "
  exit
else
  begin
    f = File.open(ARGV[0])
    f.each do |line|
      (v1, v2, cost) = line.split(",")
      cost = cost.strip.to_i
    end
  rescue => FOPEN_ERR
    puts "Error reading source file: #{FOPEN_ERR}"
    FOPEN_ERR
  end
end
