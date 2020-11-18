module Validation
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    @@VALIDATION_TYPE = [:presence, :format, :type]

    def validate(name, type, *params)
      case type
      when :presence
       raise 'Name is blank!' if name.empty? || !!name
      when :format
       raise 'Err format!' if name !~ params[1] 
      when :type
       raise 'Type err!' if name.class != params[1]
      end 
    end 
  end  
  
  module InstanceMethods
    def validate!
      @@VALIDATION_TYPE.each do |validation|
        self.class.validate(self.name, validation)
      end
    end
  end  
end