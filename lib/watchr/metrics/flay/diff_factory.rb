module Watchr
  module FlayMetric
    class DiffFactory
      def self.build(same, nodes, bonus, mass)
        diff = Diff.new(same, nodes, bonus, mass)

        nodes.each do |x|
          diff.add_location(Location.new(x.file, x.line - 1))
        end

        diff
      end
    end
  end
end