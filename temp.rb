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
