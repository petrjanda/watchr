module Watchr
  class FlogReportFormatter
    def self.generate(flog_report)
      result = {}

      result[:total_score] = flog_report.total_score
      result[:classes] = flog_report.classes.map do |clazz|
        {
          :name => clazz.name,
          :total_score => clazz.total_score,
          :methods_total_score => clazz.total_methods_score,
          :file => clazz.file,
          :methods => clazz.methods.map do |method|
            {
              :name => method.name,
              :total_score => method.total_score,
              :file => method.file,
              :line => method.line
            }
          end
        }
      end
    
      result
    end
  end
end

