class Train 
  attr_reader :number, :speed, :wagons, :current_station

  def initialize(number)
    @number = number
    @wagons = []
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

  protected

  def wagons_hook
    @wagons << wagon if @speed == 0
  end 

  def wagons_unhook
    @wagons.delete(wagon) if @speed == 0
  end

end 


