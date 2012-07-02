module Watchr
  class FlogReportMethod
    attr_reader :clazz, :name, :total_score, :file, :line

    def initialize(clazz, name, score, location)
      @clazz = clazz
      @full_name = name
      @name = name.split(/#|::/).last
      @total_score = (10 * score).round / 10.0
      @file, @line = location.split(':')
      @line = @line.to_i
    end

    def full_name
      @full_name
    end
  end
end
