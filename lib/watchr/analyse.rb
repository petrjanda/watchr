require 'watchr/paths'
require 'watchr/metrics/flay/report'
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
    attr_reader :files, :path

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
        Watchr::FileAnalyse.new(file).tap { |file|
          file.flay(flay.duplications_by_file(file))
        }
      end

      @path = path
    end
  end
end

