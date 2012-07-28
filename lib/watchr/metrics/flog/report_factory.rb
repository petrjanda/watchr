module Watchr
  module FlogMetric
    class ReportFactory
      def self.build(methods, method_locations, scores)
        scores.map do |klass, total|
          build_class_report(klass, total, methods[klass], method_locations)
        end
      end

      private 

      def self.build_class_report(klass, total, methods, method_locations)
        clazz = FlogReportClass.new(klass, total)

        methods.each do |name, score|
          next if name =~ /#none/

          clazz.add_method(
            FlogReportMethod.new(
              clazz, name, score,
              Location.from_path(method_locations[name])
            )
          )
        end

        clazz
      end
    end
  end
end