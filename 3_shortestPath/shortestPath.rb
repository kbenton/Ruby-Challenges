#!/usr/bin/ruby
require 'pp'
require 'lib/node.rb'
include ShortestPath

INFINITY = 1.0/0

vertices       = {}
edgeCosts      = {}
totalCostTo    = {}
previous       = {}
visited        = []
toVisit        = {}

def closestVertex(vertexHash)
  lowestCost = INFINITY
  closest = nil

  vertexHash.each_pair do |id, v|
    if v.sourceCostTo < lowestCost
      lowestCost = v.sourceCostTo
      closest = v
    end
  end
  closest
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

      if not vertices.keys.include?(v1)
        n = Node.new(v1)
        n.sourceCostTo = INFINITY

        vertices[v1] = n
      end

      if not vertices.keys.include?(v2)
        n = Node.new(v2)
        n.sourceCostTo = INFINITY
        vertices[v2] = n
      end

      vertices[v1].add_neighbor(v2, cost)
      vertices[v2].add_neighbor(v1, cost)
    end
  rescue => FOPEN_ERR
    puts "Error reading source file: #{FOPEN_ERR}"
    FOPEN_ERR
  end
end

# initialize the source object...
sourceVertex = vertices["A"]
sourceVertex.sourceCostTo = 0
toVisit[sourceVertex.id] = sourceVertex

pp vertices
puts "------------------------"

destVertex = vertices["G"]

while toVisit.length > 0 do
  v = closestVertex(toVisit)
  toVisit.delete(v.id)

  if v.id == destVertex.id
    break
  end

  visited << v.id

  v.neighbors.each do |n|
    if !visited.include?(n)
      pathCost = v.sourceCostTo + v.costTo(n)
      if vertices[n].sourceCostTo > pathCost
        vertices[n].sourceCostTo = pathCost
        previous[n] = v.id
        toVisit[n] = vertices[n]
      end
    end
  end
end

pathEnd = "G"
path = []
while pathEnd != "A" do
  path << pathEnd
  pathEnd = previous[pathEnd]
end

path << "A"

puts path.reverse
