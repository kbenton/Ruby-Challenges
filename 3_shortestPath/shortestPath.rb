#!/usr/bin/ruby
require 'pp'

INFINITY = 1.0/0

neighbors      = {}
edgeCosts      = {}
totalCostTo    = {}
vertices       = []
previous       = {}

source = "A"
dest   = "G"

def closestVertex(costs)
   costs.to_a.sort[0][0]
end

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

      if not vertices.include?(v1)
        vertices << v1
      end
      if not vertices.include?(v2)
        vertices << v2
      end

      if not neighbors.keys.include?(v1)
        neighbors[v1] = [v2]
      else
        neighbors[v1] << v2
      end

      if not neighbors.keys.include?(v2)
        neighbors[v2] = [v1]
      else
        neighbors[v2] << v1
      end

      if not totalCostTo.keys.include?(v1)
        totalCostTo[v1] = INFINITY
        previous[v1] = nil
      end

      if not totalCostTo.keys.include?(v2)
        totalCostTo[v2] = INFINITY
        previous[v2] = nil
      end

      edge = [v1, v2].sort.join
      if not edgeCosts.include?(edge)
        edgeCosts[edge] = cost
      end
    end
  rescue => FOPEN_ERR
    puts "Error reading source file: #{FOPEN_ERR}"
    FOPEN_ERR
  end
end

vertices

pp vertices
puts "---"
pp totalCostTo
puts "---"
pp edgeCosts
puts "---"
pp neighbors
puts "---"
pp previous

# initialize the source...
totalCostTo[source] = 0

while vertices != []
  v = closestVertex(totalCostTo)
  if v == INFINITY
    break
  else
    puts "#{v} -->"
    vertices.delete(v)
    neighbors[v].each do |n|
      edge = [v, n].sort.join
      currentCost = totalCostTo[v] + edgeCosts[edge]
      puts "#{v} :: #{n} :: #{edge} :: #{edgeCosts[edge]} #{currentCost}"
      puts ">> #{totalCostTo[n]}"
      if currentCost < totalCostTo[n]
        totalCostTo[n] = currentCost
        previous[n] = v
      end
      exit
    end
  end
  puts " << #{totalCostTo[v]}"
end


