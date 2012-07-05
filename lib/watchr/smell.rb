module Watchr
  class Smell

    #
    # Method complexity is high.
    #
    COMPLEX_METHOD = :complex_method

    #
    # Method complexity is very high.
    #
    VERY_COMPLEX_METHOD = :very_complex_method

    #
    # Object (class / module) total complexity is high.
    #
    COMPLEX_OBJECT = :complex_object

    #
    # Object (class / module) total complexity is very high.
    #
    VERY_COMPLEX_OBJECT = :very_complex_object

    #
    # Code in multiple places is identical.
    #
    IDENTICAL_CODE = :identical_code

    #
    # Code in multiple places is similar (not identical).
    #
    SIMILAR_CODE = :similar_code

    def initialize(type, context, locations, description)
      @type = type
      @context = context
      @description = description
      @locations = []

      locations.each {|l| add_location(l)}
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

    def add_location(location)
      @locations << location
    end
  end
end
