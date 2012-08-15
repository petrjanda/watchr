require 'watchr/metrics/flog/class'
require 'watchr/metrics/flog/method'
require 'watchr/location'

module Watchr
  module FlogMetric
    class ClassReportFactory
      def self.build(klass, total, methods, method_locations)
        clazz = FlogReportClass.new(klass, total)

        methods.each do |name, score|
          next if name =~ /#none/

          method_location = method_locations[name]
          location = method_location ? Location.from_path(method_location) : nil

          clazz.add_method(FlogReportMethod.new(clazz, name, score, location))
        end

        clazz
      end
    end
  end
end