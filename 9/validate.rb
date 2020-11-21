# module Validation
#   def self.included(base)
#     base.send :include, InstanceMethods
#     base.extend ClassMethods
#   end

#   module ClassMethods
#     @@VALIDATION_TYPE = [:presence, :format, :type]
#       #Принимает имя, тип валидации и доп параметры
#     def validate(name, type, *params)
#       case type
#       when :presence
#        raise 'Name is blank!' if name.empty? || name.nil?
#       when :format
#        raise 'Err format!' if name !~ params[1]
#       when :type
#        raise 'Type err!' if name.class != params[1]
#       end
#       return true
#     end
#   end

#   module InstanceMethods
#     def validate!
#       #Выполняет все проверки из метода класса validate. Ошибка - сообщение
#       @@VALIDATION_TYPE.each do |validation|
#         self.class.validate(self.name, validation)
#       end
#     end

#     def valid?
#       validate!
#     rescue RuntimeError
#       false
#     end
#   end
# end

# ---------------------------------------------------------------
module Validation
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :validates

    def validate(name, *args)
      @validates ||= []
      @validates << { name: args }
  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |item|
        item.each do |name, args|
          self.send("validate_#{args[0]}", name, args[1])
        end
      end
      # Выполняет все проверки из метода класса validate. Ошибка - сообщение
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    protected

    def validate_presence(name, *args)
      raise 'Name is blank!' if name.empty? || name.nil?
    end

    def validate_format(name, *args)
      raise 'Incorrect format!' if name !~ args[0]
    end

    def validate_type(name, *args)
      raise 'Type err!' if name.class != args[0]
    end
  end
end
