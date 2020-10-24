class Station
  attr_reader :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def show_all
    @trains.each {|train| puts train.number}
  end

  def show_cargo
    cargo = @trains.select { |train| train.type == 'cargo'}
    puts "На станции #{cargo.length} грузовых поездов: "
    cargo.each {|train| puts train.number}
  end

  def show_passenger
    cargo = @trains.select { |train| train.type == 'passenger'}
    puts "На станции #{cargo.length} пассажирских поездов: "
    cargo.each {|train| puts train.number}
  end

  def train_left(train)
    puts "Поезд #{train.number} отправился в путь!"
    @trains.delete(train)
  end 

  #   ObjectSpace.each_object(Train) do |train|
  #     if train.point == @name
  #       cargo << train if train.type == 'cargo'
  #       passenger << train if train.type == 'passenger'
  #       puts "На станции #{@name} находится #{cargo.length} грузовых поездов и #{passenger.length} пассажирских."
  #     end
  #   end
  # end

end


class Route
  attr_reader :stations

  def initialize(first, last)
    @quantity_of_stations = 1
    @stations = []
    @stations << first
    @stations << last
  end 

  def station_add(name)
    @stations.insert(@quantity_of_stations, name)
    @quantity_of_stations += 1
  end

  def station_del(name)
    @stations.delete(name)
  end 

  def station_list
    @stations.each { |station| puts station }
  end 
end 


class Train 
  attr_reader :point, :type, :number

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end 

  def speed_up(speed)    #Разгон поезда (значение указывается  вручную)
    @speed = speed
  end 

  def speed_now
    @speed
  end 

  def speed_down          #Остановка поезда
    loop do 
      @speed -= 1         #Знаю, что излишне)) Балуюсь.
      break if speed == 0
    end
    puts "Поезд остановлен"  
  end

  def wagons_now
    puts "Число вагонов = #{@wagons}"
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
    @route = route.stations
    @i = 0                    #Переменная для вычисления текущей позиции 
    @point = @route[@i]
    puts "Поезд находится на станции #{@point}"
  end

  def forward #На одну станцию вперёд
    @point = @route[@i+=1]
    puts "Поезд приехал на станцию #{@point}"
  end

  def backward #Возврат на одну станцию назад
    @point = @route[@i-=1]
    puts "Поезд приехал на станцию #{@point}"
  end

  def navigate #Показывает текущую, предыдущую и следующую станцию на маршруте
    puts "Текущая станция - #{@route[@i]}"
    puts "Предыдущая станция - #{@route[@i-1]}"
    puts "Следующая станция - #{@route[@i+1]}"
  end 
end 