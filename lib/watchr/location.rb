module Watchr
  class Location
    attr_reader :file, :line

    def initialize(file, line)
      @file = file
      @line = line
    end
  end
end

