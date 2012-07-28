module Watchr
  module FlayMetric
    class Diff
      attr_reader :locations, :match, :nodes, :bonus, :mass, :code

      def initialize(same, nodes, bonus, mass)
        @locations = []
        @match = same ? :identical : :similar
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
