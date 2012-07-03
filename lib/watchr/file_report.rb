require 'watchr/flog_metric/report'

module Watchr
  class FileReport
    def initialize(path)
      @path = path
      @flog_report = FlogMetric::Report.new(path).classes_by_file(path)
    end

    def flay(report)
      @flay_report = report
    end
  end
end
