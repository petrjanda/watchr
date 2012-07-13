module Watchr
  module SmellTypes
    #
    # Method complexity is high.
    #
    COMPLEX_METHOD = :complex_method

    #
    # Method complexity is very high.
    #
    VERY_COMPLEX_METHOD = :very_complex_method

    #
    # Object (class / module) total complexity is high.
    #
    COMPLEX_OBJECT = :complex_object

    #
    # Object (class / module) total complexity is very high.
    #
    VERY_COMPLEX_OBJECT = :very_complex_object

    #
    # Code in multiple places is identical.
    #
    IDENTICAL_CODE = :identical_code

    #
    # Code in multiple places is similar (not identical).
    #
    SIMILAR_CODE = :similar_code


    IRRESPONSIBLE_MODULE = :irresponsible_module
    DUPLICATE_METHOD_CALL = :duplicate_method_call
    NESTED_ITERATORS = :nested_iterators
    TOO_MANY_STATEMENTS = :too_many_statements
    FEATURE_ENVY = :feature_envy
    UTILITY_FUNCTION = :utility_function

    ALL_SMELLS = [
      COMPLEX_METHOD,
      VERY_COMPLEX_METHOD,
      COMPLEX_OBJECT,
      VERY_COMPLEX_OBJECT,
      IDENTICAL_CODE,
      SIMILAR_CODE,
      IRRESPONSIBLE_MODULE,
      DUPLICATE_METHOD_CALL,
      NESTED_ITERATORS,
      TOO_MANY_STATEMENTS,
      FEATURE_ENVY,
      UTILITY_FUNCTION
    ]
  end
end
