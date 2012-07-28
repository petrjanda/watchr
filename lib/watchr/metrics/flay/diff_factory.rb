module Watchr
  module FlayMetric
    class DiffFactory
      def self.build(same, nodes, bonus, mass)
        diff = Diff.new(same, nodes, bonus, mass)

        nodes.each do |x|
          diff.add_location(Location.new(x.file, x.line))
        end

        #r2r = Ruby2Ruby.new
        #diff.code = n_way_diff(*nodes.map { |s| r2r.process(s.deep_clone) })

        diff
      end
    end
  end
end