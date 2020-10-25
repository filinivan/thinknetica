class Train 
  attr_reader :point, :type, :number, :speed, :wagons, :current_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end 

  def speed_up(speed)    #Разгон поезда (значение указывается  вручную)
    @speed += speed
  end 

  def speed_down          #Остановка поезда
    loop do 
      @speed -= 1         #Знаю, что излишне)) Балуюсь.
      break if speed == 0
    end
    puts "Поезд остановлен"  
  end 

  def wagons_hook
    @wagons += 1 if @speed == 0
    puts "Число вагонов = #{@wagons}"
  end 

  def wagons_unhook
    @wagons -= 1 if @speed == 0
    puts "Число вагонов = #{@wagons}"
  end

  def set_route(route)        #Установка маршрута 
    @route = route
    @current_station_index = 0               
    @current_station = @route.stations[@current_station_index]
    @current_station.add_train(self)
  end

  def move_forvard 
    @current_station.del_train(self)
    @current_station = @route.stations[@current_station_index += 1]
    @current_station.add_train(self)
  end

  def move_back 
    @current_station = @route.stations[@current_station_index -= 1]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end 
end 
