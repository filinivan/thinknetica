#Метод класса
def self.classmethod
  puts 'I am class method!'
end 

#МОДУЛИ--------------------------- 
#Пространство имён
module Admin
  class Car
  end
end
Обращение через Admin::Car.new

------------

extend  - Подключение методов модуля как методов экз. класса
include - Подключение методов модуля как методы класса

#SEND
  send  отправляет запрос куда-нибудь. 
!!! send видит приватные методы. 

1.send '+', 2  == 1 + 2

#Simple setter method and setter created with metaprogramming

  def car=(value)
    @car = value
  end  

  define_method("#{name}=".to_sym) do |value| 
    instance_variable_set(var_name, value)
  end

  define_method(method_name) do |value|
    puts "Value is #{value}"
  end


----------------------------------
#1
module MyAttrAccessor
def my_attr_accessor
  define_method("#{name}".to_sym) do 
    get_instance_variable("@#{name}") 
  end
  define_method("#{name}=".to_sym) do |value|
    set_instance_variable("@#{name}".to_sym, value)
  end 
end
end
#2
module MyAttrAccessor
  def my_attr_accessor(name)
    var_name = "@#{name}".to_sym
    define_method(name) { get_instance_variable(var_name) }
    define_method("#{name}=") do |value|
      set_insance_variable(var_name, value)
    end
  end
end
