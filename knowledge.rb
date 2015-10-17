def attribute (arg, &block)

  if arg.is_a? Hash
    key = arg.keys[0]
    value = arg.values[0] 
  else
    key = arg 
    value = nil
  end

  inst = '@' + key 

  define_method (key + '?') do 
    instance_variable_get(inst) { inst ? true : false }
  end

  define_method (key + '=') do |val|
    instance_variable_set(inst, val)
  end

  define_method key do
    instance_variable_defined?(inst) ? instance_variable_get(inst) : instance_variable_set(inst, (block ? instance_eval(&block) : value))
  end
end
