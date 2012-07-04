require 'watchr/flog_metric/report'

module Watchr
  #
  # Analyse for one given file. All the different metric analyse data are
  # collected in order to output reasonable recommendations for a code
  # improvements.
  #
  class FileAnalyse
    #
    # Craete new file analyse.
    #
    # @param {String} Path to file.
    #
    def initialize(path)
      @path = path
      @flog_report = FlogMetric::Report.new([path])
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
  end
end
