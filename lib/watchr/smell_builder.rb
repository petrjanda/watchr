module Watchr
  class SmellBuilder
    attr_reader :smell

    def initialize(type, context, description)
      @smell = Smell.new(type, context, description)
    end

    def add_location(file, line)
      @smell.add_location(Location.new(file, line))
    end

    def add_details(details)
      @smell.details = details
    end
  end
end