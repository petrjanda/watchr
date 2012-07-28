require 'flog'
require 'watchr/metrics/flog/class'
require 'watchr/metrics/flog/method'
require 'watchr/metrics/flog/class_report_factory'
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

      def process_scores
        scores  = Hash.new 0
        methods = Hash.new { |hash,key| hash[key] = [] }

        each_by_score(nil) do |class_method, score, call_list|
          klass = class_method.split(/#|::/)[0..-2].join('::')

          methods[klass] << [class_method, score]
          scores[klass]  += score
        end

        return methods, scores
      end

      def process_result
        methods, scores = process_scores

        @classes = scores.map do |klass, total|
          ClassReportFactory.build(klass, total, methods[klass], method_locations)
        end
      end
    end
  end
end
