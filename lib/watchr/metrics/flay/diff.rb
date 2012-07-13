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

      def add_location(location)
        @locations << location
      end

      def code=(code)
        @code = code
      end
    end
  end
end
