require 'flog'
require 'lib/watchr/flog_report_class'
require 'lib/watchr/flog_report_method'

module Watchr
  class FlogReport < Flog
    def initialize(path)
      super({})

      flog(path)
      process_result
    end

    def total_score
      (10 * total).round / 10.0
    end

    def classes
      @classes
    end

    private

    def process_result
      @classes = []

      scores  = Hash.new 0
      methods = Hash.new { |h,k| h[k] = [] }

      each_by_score(nil) do |class_method, score, call_list|
        klass = class_method.split(/#|::/).first
        methods[klass] << [class_method, score]
        scores[klass]  += score
      end

      scores.sort_by { |_, n| -n }.each do |klass, total|
        clazz = FlogReportClass.new(klass, total)

        methods[klass].each do |name, score|
          next if name =~ /#none/

          clazz.add_method(
            FlogReportMethod.new(clazz, name, score, method_locations[name])
          )
        end

        @classes << clazz
      end
    end
  end
end
