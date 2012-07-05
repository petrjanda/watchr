module Watchr
  class Location
    attr_reader :file, :line

    def initialize(file, line = nil)
      @file = file
      @line = line
    end
  end
end

