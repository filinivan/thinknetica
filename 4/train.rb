class Train 
  attr_reader :point, :type, :number, :speed, :wagons

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
    @wagons += 1
    puts "Число вагонов = #{@wagons}"
  end 

  def wagons_unhook
    @wagons -= 1
    puts "Число вагонов = #{@wagons}"
  end

  def set_route(route)        #Установка маршрута 
    @route = route
    @current_station_index = 0               
    @current_station = @route.stations[0]
    @current_station.add_train(self)
    puts "Поезд находится на станции #{@current_station}"
  end

  def forward #На одну станцию вперёд
    @current_station = @route.stations[@current_station_index += 1]
    puts "Поезд приехал на станцию #{@current_station}"
  end

  def backward #Возврат на одну станцию назад
    @current_station = @route.stations[@current_station_index -= 1]
    puts "Поезд приехал на станцию #{@current_station}"
  end

  def navigate #Показывает текущую, предыдущую и следующую станцию на маршруте
    puts "Текущая станция - #{@route.stations[@current_station_index]}"
    puts "Предыдущая станция - #{@route.stations[@current_station_index - 1]}"
    puts "Следующая станция - #{@route.stations[@current_station_index + 1]}"
  end 
end 
