module Baz
  class Foo
    attr_reader :bar

    def bar
      if true == false
        return false
      else
        return true
      end
    end

    #
    # Bar
    #
    def self.bar
      if true == false
        return false
      else
        return true
      end
    end
  end
end
