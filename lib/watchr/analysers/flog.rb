require 'watchr/smell'

module Watchr
  module Analysers
    module Flog
      include SmellTypes

      VERY_COMPLEX_OBJECT_THRESHOLD = 100

      COMPLEX_OBJECT_THRESHOLD = 50

      VERY_COMPLEX_METHOD_THRESHOLD = 40

      COMPLEX_METHOD_THRESHOLD = 25

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
        score = target.total_score

        add_smell(
          Watchr::Smell.new(
            smell_type(score, type), target.name, 
            "complexity = #{score}", target.location,
            { :complexity => score }
          )
        ) if is_complex?(score, type)
      end

      def smell_type(score, type)
        complexity = is_very_complex?(score, type) ? :very_complex : :complex

        "#{complexity}_#{type}".to_sym
      end

      def is_complex?(score, type)
        is_complex_by_level?(score, type, :complex)
      end

      def is_very_complex?(score, type)
        is_complex_by_level?(score, type, :very_complex)
      end

      def is_complex_by_level?(score, type, level)
        score >= Flog.const_get("#{level.upcase}_#{type.upcase}_THRESHOLD")
      end
    end
  end
end
