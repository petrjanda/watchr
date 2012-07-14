module Watchr
  class FlogReportMethod
    attr_reader :clazz, :name, :total_score, :location

    def initialize(clazz, name, score, location)
      @clazz = clazz
      @full_name = name
      @method_name = name.split(/#|::/).last
      @total_score = (10 * score).round / 10.0
      @location = location
    end

    def full_name
      @full_name
    end

    def method_name
      @method_name
    end

    alias :name :full_name
  end
end
