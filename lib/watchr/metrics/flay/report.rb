require 'flay'
require 'watchr/metrics/flay/diff'
require 'watchr/metrics/flay/diff_factory'
require 'watchr/location'

module Watchr
  module FlayMetric
    class Report < Flay
      attr_reader :duplications

      def initialize(path)
        super(:mass => 12, :diff => true)

        files = Flay.expand_dirs_to_files(path)

        process(*files)
        process_result
      end

      def total_score
        total
      end

      def duplications_by_file(path)
        duplications.find_all do |duplication|
          false
#          duplication.locations.any? {|location| location.file == path}
        end
      end

      def process_result
        @duplications = []

        masses.sort_by { |h,m| [-m, hashes[h].first.file] }.each do |hash, mass|
          nodes = hashes[hash]

          same = identical[hash]
          node = nodes.first
          bonus = same ? nodes.size : 0

          @duplications << DiffFactory.build(same, nodes, bonus, mass)
        end
      end
    end
  end
end
