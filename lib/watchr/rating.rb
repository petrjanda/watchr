require 'watchr/smell_types'

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
      when :complex_method,
        :very_complex_method
        0.45 * smell.options[:complexity]

      when :complex_object,
        :very_complex_object
        0.65 * smell.options[:complexity]

      when :identical_code,
        :similar_code
        smell.options[:mass]
      else
        0
      end
    end
  end
end
