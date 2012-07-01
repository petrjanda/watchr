require 'flog'

module Watchr
  class FlogReport < Flog
    def initialize(path)
      super({})

      flog(path)
      process_result
    end

    def total_score
      (10 * total).round / 10.0
    end

    def classes
      @classes
    end

    private

    def process_result
      @classes = []

      scores  = Hash.new 0
      methods = Hash.new { |h,k| h[k] = [] }

      each_by_score(nil) do |class_method, score, call_list|
        klass = class_method.split(/#|::/).first
        methods[klass] << [class_method, score]
        scores[klass]  += score
      end

      scores.sort_by { |_, n| -n }.each do |klass, total|
        clazz = FlogReportClass.new(klass, total)

        methods[klass].each do |name, score|
          next if name =~ /#none/

          clazz.add_method(
            FlogReportMethod.new(clazz, name, score, method_locations[name])
          )
        end

        @classes << clazz
      end
    end
  end

  class FlogReportClass
    attr_reader :name, :methods, :total_score

    def initialize(name, score)
      @name = name
      @total_score = (10 * score).round / 10.0
      @methods = []
    end

    def file
      @file
    end

    def total_methods_score
      @methods.reduce(0) {|sum, i| sum += i.total_score}
    end

    def add_method(method_report)
      @methods << method_report
      @file = method_report.file
    end
  end

  class FlogReportMethod
    attr_reader :clazz, :name, :total_score, :file, :line

    def initialize(clazz, name, score, location)
      @clazz = clazz
      @full_name = name
      @name = name.split(/#|::/).last
      @total_score = (10 * score).round / 10.0
      @file, @line = location.split(':')
      @line = @line.to_i
    end

    def full_name
      @full_name
    end
  end
end
