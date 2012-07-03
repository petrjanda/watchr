require 'watchr/paths'
require 'watchr/flay_metric/report'
require 'watchr/file_report'

module Watchr

  #
  # Code analyse information for a given path. Returns list of files,
  # each containing its own detailed data for used metrics.
  #
  class Analyse

    #
    # Analysed file data.
    #
    attr_reader :files

    #
    # Run the analyse.
    #
    # @param {String} Path to code folders.
    #
    def initialize(path)
      files = Paths.expand_dirs_to_files(path)

      flay = Watchr::FlayMetric::Report.new(files)

      @files = files.map do |file|
        file_report = Watchr::FileReport.new(file)
        file_report.flay(flay.duplications_by_file(file))

        file_report
      end
    end
  end
end

