require 'watchr/smell'

module Watchr
  module Analysers
    module Reek
      include SmellTypes

      def analyse_reek(report)
        report.smells.each do |reek_smell|
          smell = Watchr::Smell.new(
            underscore(reek_smell.smell['subclass']).to_sym, 
            reek_smell.location['context'], 
            reek_smell.smell['message'], 
          )

          smell.add_location(Location.new(
            reek_smell.location['source'], 
            reek_smell.location['lines'].first
          ))

          add_smell(smell)
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