module Watchr
  #
  # Flog report class information.
  #
  class FlogReportClass
    attr_reader :name, :methods, :total_score, :location

    def initialize(name, score)
      @name = name
      @total_score = (10 * score).round / 10.0
      @methods = []
    end

    def location
      @location
    end

    def total_methods_score
      @methods.reduce(0) {|sum, method| sum += method.total_score}
    end

    def add_method(method_report)
      @methods << method_report
      @location = Location.new(method_report.location.file)
    end
  end
end
