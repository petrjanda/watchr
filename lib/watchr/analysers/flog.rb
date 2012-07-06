require 'watchr/smell'

module Watchr
  module Analysers
    module Flog
      include SmellTypes

      VERY_COMPLEX_CLASS_TRASHLOLD = 100

      COMPLEX_CLASS_TRASHOLD = 50

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

      end

      def analyse_method_complexity(method)
        add_smell(
          get_complexity?(method),
          method.name, method.location, method.total_score
        ) if method.total_score >= COMPLEX_METHOD_TRASHOLD
      end

      def get_complexity?(method)
        method.total_score > VERY_COMPLEX_METHOD_TRASHOLD ?
          VERY_COMPLEX_METHOD :
          COMPLEX_METHOD
      end
    end
  end
end
