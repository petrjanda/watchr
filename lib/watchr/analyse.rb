require 'watchr/paths'
require 'watchr/flay_metric/report'
require 'watchr/file_analyse'

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
      files = Paths.files_by_dirs(path)

      # Flay essentially cant be done on file level because its first class
      # citizen is duplication of code between files. Its done once for all
      # the files in the analyse and results are injected to the proper file
      # later.
      flay = Watchr::FlayMetric::Report.new(files)

      # Create report for each file.
      @files = files.map do |file|
        file_report = Watchr::FileAnalyse.new(file)
        file_report.flay(flay.duplications_by_file(file))

        file_report
      end
    end
  end
end

