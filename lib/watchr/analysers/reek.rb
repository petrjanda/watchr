require 'watchr/smell_builder'

module Watchr
  module Analysers
    module Reek
      include SmellTypes

      def analyse_reek(report)
        report.smells.each do |reek_smell|
          puts reek_smell.context.inspect


          puts reek_smell.smell_type

          builder = Watchr::SmellBuilder.new(
            underscore(reek_smell.smell_type).to_sym,
            reek_smell.context,
            reek_smell.message
          )

          builder.add_location(
            reek_smell.source,
            reek_smell.lines.first
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
