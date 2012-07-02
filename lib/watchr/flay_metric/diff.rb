module Watchr
  module FlayMetric
    class Diff
      IDENTICAL = :identical

      SIMILAR = :similar

      attr_reader :locations, :match, :nodes, :bonus, :mass, :code

      def initialize(same, nodes, bonus, mass)
        @locations = []
        @match = same ? IDENTICAL : SIMILAR
        @nodes = nodes
        @bonus = bonus
        @mass = mass
      end

      def add_location(file, line)
        @locations << DiffLocation.new(file, line)
      end

      def code=(code)
        @code = code
      end
    end

    class DiffLocation
      attr_reader :file, :line

      def initialize(file, line)
        @file = file
        @line = line
      end
    end
  end
end
