module ShortestPath
  class Node
    attr_reader :id

    def initialize(id)
      @id = id

      @neighbors = Array.new
    end
  end
end
