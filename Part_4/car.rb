class Car 
  attr_accessor :color
  attr_reader :number, :door_title

  def initialize(number)
    @number = number
    @color = 'white'
  end 

  def beep 
    puts 'Beep beep'
  end

  def change_door_title(driver)
    @door_title = driver.name if driver.cars.include?(self)
  end
end

class Driver
  attr_reader :name, :cars
  
  def initialize(name)
    @name = name
    @cars = []
  end 

  def buy_car(car)
    @cars << car 
    car.change_door_title(self)
  end  

  def show_cars
    @cars.each
  end
end
