module Watchr
  class Report
    def initialize(path)
      @flog = FlogMetric::Report.new(path)
      @flay = FlayMetric::Report.new(path)


    end
  end
end
