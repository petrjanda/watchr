require 'watchr/flog_metric/report'
require 'watchr/smell'
require 'watchr/smells_collector'

require 'watchr/analysers/flog'

module Watchr
  #
  # Analyse for one given file. All the different metric analyse data are
  # collected in order to output reasonable recommendations for a code
  # improvements.
  #
  class FileAnalyse
    include Analysers::Flog

    attr_reader :path

    #
    # Craete new file analyse.
    #
    # @param {String} Path to file.
    #
    def initialize(path)
      @path = path
      @smells = SmellsCollector.new

      flog_metric = FlogMetric::Report.new([path])
      flog_metric.classes.each do |klass|
        if klass.total_score > 150
          @smells.add(
            Smell.new(
              Smell::VERY_COMPLEX_OBJECT,
              klass.name,
              [klass.location],
              klass.total_score
            )
          )
        end

        if klass.total_score > 50
          @smells.add(
            Smell.new(
              Smell::COMPLEX_OBJECT,
              klass.name,
              [klass.location],
              klass.total_score
            )
          )
        end
      end
    end

    def smelly?
      smells.any?
    end

    #
    # Store the flay report, which was evaluated on global basis
    # to check for duplications across multiple files.
    #
    # @param {Array.<Watchr::FlayMetric::Diff>} Duplication details.
    # @return nil
    #
    def flay(report)
      @flay_report = report
    end

    def smells
      @smells.all
    end
  end
end
