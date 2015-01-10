module Watchr
  module SmellTypes
    ALL_SMELLS = [
      :complex_method,
      :very_complex_method,
      :complex_object,
      :very_complex_object,
      :too_many_statements,

      :identical_code,
      :similar_code,

      :control_parameter,
      :attribute,
      :boolean_parameter,
      :class_variable,
      :control_couple,
      :data_clump,
      :duplication,
      :duplicate_method_call,
      :feature_envy,
      :irresponsible_module,
      :large_class,
      :long_method,
      :long_parameter_list,
      :long_yield_list,
      :nested_iterators,
      :simulated_polymorphism,
      :uncommunicative_method_name,
      :uncommunicative_module_name,
      :uncommunicative_parameter_name,
      :uncommunicative_variable_name,
      :utility_function,

      :too_many_instance_variables,
      :too_many_methods,
      :repeated_conditional,

      :nil_check,
      :prima_donna_method,
      :unused_parameters
    ]
  end
end
