require 'watchr/smell_builder'

module Watchr
  module Analysers
    module Reek
      include SmellTypes

      def analyse_reek(report)
        report.smells.each do |reek_smell|
          location = reek_smell.location
          smell = reek_smell.smell

          builder = Watchr::SmellBuilder.new(
            underscore(smell['subclass']).to_sym, 
            location['context'], 
            smell['message'], 
          )

          builder.add_location(
            location['source'], 
            location['lines'].first
          )

          add_smell(builder.smell)
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