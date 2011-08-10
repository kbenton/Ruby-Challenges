module ShortestPath
  class node
    attr_reader :id
    attr_accessor :source? :current?

    def initialize(id)
      @id = id

      @neighbors = Hash.new
      @neighbors = {}
    end
  end
end
