module Watchr
  module FlogMetric
    class ClassReportFactory
      def self.build(klass, total, methods, method_locations)
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