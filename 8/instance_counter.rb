module InstanceCounter

  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :instances

    def counter 
      @instances ||= 0
      @instances += 1
    end 
  end

  module InstanceMethods
    private
    
    def register_instance
      self.class.counter
    end
  end

end
