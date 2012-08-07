require 'watchr/smell_types'

module Watchr
  class Smell
    include SmellTypes

    attr_reader :type, :locations, :description, :context
    attr_accessor :details

    def initialize(type, context, description)
      @type = type
      @context = context
      @description = description
      @locations = []
    end

    def add_location(location)
      @locations << location
    end
  end
end
