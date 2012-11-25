class Stats
  def initialize(path)
    @path = path

    calculate_statistics
  end

  private

  def calculate_statistics
    stats = { "lines" => 0, "codelines" => 0, "classes" => 0, "methods" => 0 }

    comment_started = false
    comment_pattern = /^\s*#/

    File.open(@path) do |f|
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

    stats
  end
end