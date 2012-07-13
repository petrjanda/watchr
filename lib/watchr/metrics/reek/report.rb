require 'reek'

module Watchr
  module ReekMetric
    class Report
      def initialize(path)
        @warnings = Reek::Examiner.new(path).all_active_smells
      end

      def smells
        @warnings
      end
    end
  end
end