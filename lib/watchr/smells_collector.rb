module Watchr
  class SmellsCollector
    def initialize
      @smells = Set.new
    end

    def add(smell)
      @smells.add(smell)
    end

    def all
      @smells
    end

    def empty?
      @smells.empty?
    end
  end
end
