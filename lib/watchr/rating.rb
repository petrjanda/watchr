module Watchr
  module Rating
    include SmellTypes
  
    def rating
      total = smells.reduce(0) {|total, smell| total += rate(smell)}

      [100, 60, 40, 20, 10].each_with_index do |limit, i|
        return %w(F E D C B A)[i] if total > limit
      end
    end

    private

    def rate(smell)
      case smell.type
      when COMPLEX_METHOD,
        VERY_COMPLEX_METHOD,
        COMPLEX_OBJECT,
        VERY_COMPLEX_OBJECT
        smell.options.total_score

      when IDENTICAL_CODE,
        SIMILAR_CODE
        smell.options.mass
      end
    end
  end
end
