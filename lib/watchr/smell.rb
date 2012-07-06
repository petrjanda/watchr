require 'watchr/smell_types'

module Watchr
  class Smell
    include SmellTypes

    def initialize(type, context, description, locations, options)
      @type = type
      @context = context
      @description = description
      @locations = []
      @options = options

      Array(locations).each {|l| add_location(l)}
    end

    def type
      @type
    end

    def locations
      @locations
    end

    def description
      @description
    end

    def context
      @context
    end

    def options
      @options
    end

    def add_location(location)
      @locations << location
    end
  end
end
