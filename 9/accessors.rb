module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_name_history = "@#{name}_nistory.to_sym"

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          if instance_variable_get(var_name_history).nil?
            instance_variable_set(var_name_history, [])
          else
            instance_variable_get(var_name_history) << instance_variable_get(var_name)
          end
          instance_variable_set(var_name, value)
        end

        define_method("#{var_name}_nistory") { instance_variable_get(var_name_history) }
      end
    end

    def strong_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do
        if instance_variable_get(var_name).instance_of?(type)
          instance_variable_set(var_name, value)
        else
          raise 'Ошибка - несоответсвие типа переменной'
        end
      end
    end
  end
end
