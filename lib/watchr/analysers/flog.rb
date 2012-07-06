require 'watchr/smell'

module Watchr
  module Analysers
    module Flog
      include SmellTypes

      VERY_COMPLEX_OBJECT_TRASHOLD = 100

      COMPLEX_OBJECT_TRASHOLD = 50

      VERY_COMPLEX_METHOD_TRASHOLD = 40

      COMPLEX_METHOD_TRASHOLD = 20

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
          get_smell_level?(target, type),
          target.name, target.location, target.total_score
        ) if target.total_score >= get_trashold(:complex, type.upcase)
      end

      def get_smell_level?(target, type)
        trashold = get_trashold(:very_complex, type)
        complexity = target.total_score >= trashold ?
          :very_complex : :complex

        get_smell_type(complexity, type.upcase)
      end

      def get_trashold(complexity, type)
        Watchr::Analysers::Flog.const_get("#{complexity.upcase}_#{type.upcase}_TRASHOLD")
      end

      def get_smell_type(complexity, type)
        Watchr::SmellTypes.const_get("#{complexity.upcase}_#{type.upcase}")
      end
    end
  end
end
