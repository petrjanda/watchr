require 'watchr/smell_types'

module Watchr
  #
  # Component responsible to rate a file considering found smells.
  #
  module Rating
    include SmellTypes
  
    def rating
      total = smells.reduce(0) {|total, smell| total += rate(smell)}

      [200, 140, 90, 50, 20, 0].each_with_index do |limit, index|
        return %w(F E D C B A)[index] if total >= limit
      end
    end

    private

    def rate(smell)
      case smell.type
      when :complex_method,
        :very_complex_method
        0.45 * smell.details[:complexity]

      when :complex_object,
        :very_complex_object
        0.65 * smell.details[:complexity]

      when :identical_code,
        :similar_code
        smell.details[:mass]
      else
        0
      end
    end
  end
end
