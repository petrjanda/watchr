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

          type = case smell.smell['subclass']
          when 'IrresponsibleModule' then IRRESPONSIBLE_MODULE
          when 'DuplicateMethodCall' then DUPLICATE_METHOD_CALL
          when 'NestedIterators' then NESTED_ITERATORS
          when 'TooManyStatements' then TOO_MANY_STATEMENTS
          when 'FeatureEnvy' then FEATURE_ENVY
          when 'UtilityFunction' then UTILITY_FUNCTION
          else nil
          end

          add_smell(Watchr::Smell.new(
            smell.smell['subclass'],
            smell.location['context'], smell.smell['message'], location, {}
          )) unless type.nil?
        end
      end
    end
  end
end