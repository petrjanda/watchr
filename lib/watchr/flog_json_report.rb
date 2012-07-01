require 'json'

module Watchr
  class FlogJsonReport
    def initialize(flog_report)
      result = {}

      result[:total_score] = flog_report.total_score

      JSON.stringify(result)
    end
  end
end

