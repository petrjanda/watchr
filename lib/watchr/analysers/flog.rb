require 'watchr/smell'

module Watchr
  module Analysers
    module Flog
      include SmellTypes

      VERY_COMPLEX_OBJECT_THRESHOLD = 100

      COMPLEX_OBJECT_THRESHOLD = 50

      VERY_COMPLEX_METHOD_THRESHOLD = 40

      COMPLEX_METHOD_THRESHOLD = 20

      def analyse_flog(report)
        report.classes.each do |klass|
          analyse_class_complexity(klass)

          klass.methods.each do |method|
            analyse_method_complexity(method)
          end
        end
      end

      protected

      def analyse_class_complexity(klass)
        analyse_complexity(klass, :object)
      end

      def analyse_method_complexity(method)
        analyse_complexity(method, :method)
      end

      def analyse_complexity(target, type)
        add_smell(
          Watchr::Smell.new(
            get_smell_level?(target, type),
            target.name, "complexity = #{target.total_score}", target.location
          )
        ) if target.total_score >= get_threshold(:complex, type.upcase)
      end

      def get_smell_level?(target, type)
        threshold = get_threshold(:very_complex, type)
        complexity = target.total_score >= threshold ? :very_complex : :complex

        get_smell_type(complexity, type)
      end

      def get_threshold(complexity, type)
        Watchr::Analysers::Flog.const_get("#{complexity.upcase}_#{type.upcase}_THRESHOLD")
      end

      def get_smell_type(complexity, type)
        "#{complexity}_#{type}".to_sym
      end
    end
  end
end
