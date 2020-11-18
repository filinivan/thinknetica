module Validate
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def validate(name, type, *params)
      
      case type
      when :presence
       raise 'Name is blank!' if name.empty? || !!name
      when :format
       raise 'Err format!' if name !~ params[1] 
      when :type
    end 
  end   
end