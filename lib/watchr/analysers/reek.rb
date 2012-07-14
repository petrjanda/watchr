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
            underscore(smell.smell['subclass']).to_sym, 
            smell.location['context'], 
            smell.smell['message'], 
            location
          ))
        end
      end

      private 

      def underscore(text)
        text.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
      end
    end
  end
end