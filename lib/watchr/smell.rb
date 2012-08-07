require 'watchr/smell_types'

module Watchr
  class Smell
    include SmellTypes

    def initialize(type, context, description)
      @type = type
      @context = context
      @description = description
      @locations = []
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

    def details
      @details
    end

    def details=(details)
      @details = details
    end

    def add_location(location)
      @locations << location
    end
  end
end
