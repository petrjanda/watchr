require 'flog'
require 'watchr/flog_metric/class'
require 'watchr/flog_metric/method'
require 'watchr/location'

module Watchr
  module FlogMetric

    #
    # Seattle.rb Flog report.
    #
    class Report < Flog

      #
      # Generate flog report for a given files.
      #
      # @param {Array} Array of file paths.
      #
      def initialize(files)
        super({})

        flog(files)
        process_result
      end

      #
      # Get total complexity score.
      #
      # @return {Number} Score.
      #
      def total_score
        (10 * total).round / 10.0
      end

      #
      # Get list of class reports.
      #
      # @return {Array.<FlogReportClass>} List of class reports.
      #
      def classes
        @classes
      end

      def classes_by_file(file)
        classes.find_all {|klass| klass.file == file}
      end

      private

      def process_result
        @classes = []

        scores  = Hash.new 0
        methods = Hash.new { |h,k| h[k] = [] }

        each_by_score(nil) do |class_method, score, call_list|
          klass = class_method.split(/#|::/)[0..-2].join('::')

          methods[klass] << [class_method, score]
          scores[klass]  += score
        end

        scores.each do |klass, total|
          clazz = FlogReportClass.new(klass, total)

          methods[klass].each do |name, score|
            next if name =~ /#none/

            clazz.add_method(
              FlogReportMethod.new(
                clazz,
                name,
                score,
                Location.from_path(method_locations[name])
              )
            )
          end

          @classes << clazz
        end
      end
    end
  end
end
