module Watchr
  module Stats
    class Report
      attr_reader :loc, :code_loc, :classes, :methods

      def initialize(file_name)
        @file_name = file_name

        calculate_statistics
      end

      private

      def calculate_statistics
        stats = { "lines" => 0, "codelines" => 0, "classes" => 0, "methods" => 0 }

        comment_started = false
        comment_pattern = /^\s*#/

        File.open(@file_name) do |f|
          while line = f.gets
            stats["lines"] += 1

            if(comment_started)
              if line =~ /^=end/
                comment_started = false
              end
              next
            else
              if line =~ /^=begin/
                comment_started = true
                next
              end
            end
            
            stats["classes"]   += 1 if line =~ /^\s*class\s+[_A-Z]/
            stats["methods"]   += 1 if line =~ /^\s*def\s+[_a-z]/
            stats["codelines"] += 1 unless line =~ /^\s*$/ || line =~ comment_pattern
          end
        end


        @loc = stats["lines"]
        @code_loc = stats["codelines"]
        @classes = stats["classes"]
        @methods = stats["methods"]
        stats
      end
    end
  end
end