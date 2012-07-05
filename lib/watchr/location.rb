module Watchr
  class Location
    attr_reader :file, :line

    def initialize(file, line = nil)
      @file = file
      @line = line
    end

    def self.from_path(path)
      file, line = path.split(':')
      line = line && line.to_i

      Location.new(file, line)
    end
  end
end

