require 'watchr/smell'
require 'watchr/smell_types'

module Watchr
  class SmellBuilder
    include SmellTypes

    attr_reader :smell

    def initialize(type, context, description)
      assert_smell_type(type)

      @smell = Smell.new(type, context, description)
    end

    def add_location(file, line)
      @smell.add_location(Location.new(file, line))
    end

    def add_details(details)
      @smell.details = details
    end

    private

    def assert_smell_type(type)
      raise "Invalid smell type '#{type}'" \
        unless ALL_SMELLS.include?(type)
    end
  end
end