require 'watchr/smell'

module Watchr
  module Analysers
    module Reek
      include SmellTypes

      def analyse_reek(report)
        report.smells.each do |smell|
          location = Location.new(
            smell.location['source'], 
            smell.location['lines'].first
          )

          add_smell(Watchr::Smell.new(
            smell.smell['subclass'],
            smell.location['context'], smell.smell['message'], location, {}
          ))
        end
      end
    end
  end
end