module ShortestPath
  class Node
    attr_reader :id
    attr_accessor :sourceCostTo

    def initialize(id)
      @id = id

      @neighbors = Hash.new
    end

    def add_neighbor(v, cost)
      if not @neighbors.keys.include?(v)
          @neighbors[v] = cost
      end
    end

    def neighbors
      @neighbors.keys
    end

    def costTo(n)
      @neighbors[n]
    end

  end
end
