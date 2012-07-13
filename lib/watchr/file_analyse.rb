require 'watchr/metrics/flog/report'
require 'watchr/metrics/reek/report'
require 'watchr/smell'
require 'watchr/smells_collector'
require 'watchr/analysers/flog'
require 'watchr/analysers/reek'
require 'watchr/rating'

module Watchr
  #
  # Analyse for one given file. All the different metric analyse data are
  # collected in order to output reasonable recommendations for a code
  # improvements.
  #
  class FileAnalyse
    include Analysers::Flog
    include Analysers::Reek
    include Rating

    attr_reader :path

    #
    # Craete new file analyse.
    #
    # @param {String} Path to file.
    #
    def initialize(path)
      @path = path
      @smells = SmellsCollector.new
      
      analyse_flog(FlogMetric::Report.new([path]))
      analyse_reek(ReekMetric::Report.new([path]))
    end

    def smelly?
      smells.any?
    end

    #
    # Store the flay report, which was evaluated on global basis
    # to check for duplications across multiple files.
    #
    # @param {Array<Watchr::FlayMetric::Diff>} Duplication details.
    # @return nil
    #
    def flay(report)
      @flay_report = report
    end

    def smells
      @smells.all
    end

    def add_smell(smell)
      @smells.add(smell)
    end
  end
end
