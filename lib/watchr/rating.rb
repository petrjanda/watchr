module Watchr
  module Rating
    include SmellTypes
  
    def rating
      total = smells.reduce(0) {|total, smell| total += rate(smell)}

      [200, 140, 90, 50, 20, 0].each_with_index do |limit, i|
        return %w(F E D C B A)[i] if total >= limit
      end
    end

    private

    def rate(smell)
      case smell.type
      when COMPLEX_METHOD,
        VERY_COMPLEX_METHOD
        0.4 * smell.options[:score]

      when COMPLEX_OBJECT,
        VERY_COMPLEX_OBJECT
        0.6 * smell.options[:score]

      when IDENTICAL_CODE,
        SIMILAR_CODE
        smell.options[:mass]
      end
    end
  end
end
