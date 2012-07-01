module Watchr
  class FlogReportClass
    attr_reader :name, :methods, :total_score

    def initialize(name, score)
      @name = name
      @total_score = (10 * score).round / 10.0
      @methods = []
    end

    def file
      @file
    end

    def total_methods_score
      @methods.reduce(0) {|sum, i| sum += i.total_score}
    end

    def add_method(method_report)
      @methods << method_report
      @file = method_report.file
    end
  end
end
