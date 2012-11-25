module Watchr
  module Stats
    class Report
      attr_reader :loc, :code_loc

      def initialize(file_name)
        @file_name = file_name

        @loc = 0
        @code_loc = 0
        @inside_comment = false

        calculate
      end

      private

      def calculate
        File.open(@file_name) do |file|
          while line = file.gets
            calculate_line(line)
          end
        end
      end

      def calculate_line(line)
        @loc += 1

        comment_end if inside_comment? && line =~ /^=end/
        comment_start if line =~ /^=begin/
        
        @code_loc += 1 unless line =~ /^\s*$/ || line =~ /^\s*#/
      end

      def inside_comment?
        @inside_comment
      end

      def comment_start
        @inside_comment = true
      end

      def comment_end
        @inside_comment = false
      end
    end
  end
end