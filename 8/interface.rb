class Interface
  
  def initialize
    @trains = []
    @routes = []
    @stations = []
    @wagons = []
  end

  def start
    loop do
      puts '1. Создать станцию'
      puts '2. Создать поезд'
      puts '3. Создать маршрут'
      puts '4. Управлять маршрутом'
      puts '5. Установить маршрут'
      puts '6. Прицепить вагон'
      puts '7. Отцепить вагон'
      puts '8. Двигать поезд по маршруту'
      puts '9. Все станции на маршруте'
      puts '10. Показать все поезда на конкретной станции'
      puts '11. Создать вагон'
      puts '12. Показать информацию по всем поездам'
      puts '13. Заполнить вагон'
      puts '0 Для выхода'
      puts 'Выберите пункт: '

      input = gets.chomp.to_i

      case input
      when 1
        create_new_station
      when 2
        create_new_train
      when 3
        create_new_route
      when 4
        control_route
      when 5
        set_route
      when 6
        wagons_hook
      when 7
        wagons_unhook
      when 8
        control_train
      when 9
        show_stations_on_route
      when 10
        show_station_trains
      when 11
        create_wagon
      when 12
        all_trains
      when 13
        fill_wagon
      when 0
        break
      else
        puts 'Неверное значение!'
      end 
    end
  end

  def seed
    @stations << Station.new('Omsk')
    @stations << Station.new('Kazan')
    @trains << TrainCargo.new('car-t1')
    @trains << TrainPassenger.new('pas-t1')
    @trains[0].wagons_hook(CargoWagon.new(5000))
    @trains[1].wagons_hook(PassengerWagon.new(220))
    @routes << Route.new(@stations[0], @stations[1])
    @trains[0].set_route(@routes[0])
    @trains[1].set_route(@routes[0])


  end

  private

  def create_new_station
    puts 'Введите название станции: '
    name = gets.chomp
    @stations << Station.new(name)
  end

  def create_new_train
    begin
      puts 'Поезд грузовой? y/n'
      cargo = gets.chomp
      puts 'Введите номер поезда в формате ХХХ-ХХ или ХХХХХ'
      number = gets.chomp
      if cargo == 'y'
        @trains << TrainCargo.new(number)
      else
        @trains << TrainPassenger.new(number)
      end
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end

  def create_new_route
    @stations.each.with_index(1) do |station, i|
      puts "#{i} - #{station.name}"
    end 
    first = gets.to_i - 1
    last = gets.to_i - 1
    route = Route.new(@stations[first], @stations[last])
    @routes << route
  end

  def control_route
    show_routes
    route = @routes[gets.to_i - 1]
    answer = gets.chomp
    if answer == '1'
      route.station_list
      route.station_add(@stations[gets.to_i - 1])
    elsif answer =='2'
      route.station_list
      route.station_del(route.stations[gets.to_i - 1])
    end
  end

  def set_route
    train = select_train
    show_routes
    train.set_route(@routes[gets.to_i - 1])
  end

  def wagons_hook
    train = select_train
    puts 'Выберите вагон: '
    @wagons.each.with_index(1) {|wagon, i| puts "#{i} - #{wagon.class}"}
    wagon = @wagons[gets.to_i - 1]
    if train.class == TrainPassenger && wagon.class == PassengerWagon
        train.wagons_hook(wagon)
        @wagons.delete(wagon)
    elsif train.class == TrainCargo && wagon.class == CargoWagon
        train.wagons_hook(wagon)
        @wagons.delete(wagon)
    end
  end

  def wagons_unhook
    train = select_train
    puts 'Выберите вагон: '
    train.wagons.each.with_index(1) {|wagon, i| puts "#{i} - #{wagon.class}"}
    wagon = train.wagons[gets.to_i - 1] 
    @wagons << wagon
    train.wagons_unhook(wagon)
  end

  def control_train
    train = select_train
    puts '1 - двигать поезд вперёд, 2 - двигать поезд назад'
    case gets.chomp
    when '1'
      train.move_forvard
    when '2'
      train.move_back
    end
  end

  def select_train
    puts 'Выберите поезд: '
    trains
    train = @trains[gets.to_i - 1]
  end

  def select_wagon
    puts 'Выберите вагон: '
    @wagons.each.with_index(1) {|wagon, i| puts "#{i} - #{wagon.class}"}
    @wagons[gets.to_i - 1]
  end

  def trains
    @trains.each.with_index(1) {  |train, x| puts "#{x}. #{train.number} | количество вагонов в составе:  #{train.wagons.size} | класс #{train.class}" }
  end

  def show_routes
    @routes.each.with_index(1) { |route, x| puts "#{x}. #{route.name}" }
  end

  def show_stations
    @stations.each.with_index(1) { |station, x| puts "#{x}. #{station.name} | поездов #{station.trains.size}" }
  end

  def show_stations_on_route
    puts 'Укажите маршрут: '
    @routes.each.with_index(1) { |route, i| puts "#{i} - #{route.name}"}
    route = @routes[gets.to_i - 1]
    route.stations.each { |station| puts station.name }
  end  

  def show_station_trains
    show_stations
    station = @stations[gets.to_i - 1]
    station.trains.each {|train| puts "#{train.number} - #{train.class}"}
  end

  def all_trains
    @stations.each do |station|
      puts "#{station.name} ......................"
      station.enum_trains do |train| 
        puts "Номер: #{train.number}, тип: #{train.class}, кол-во вагонов: #{train.wagons.length} "
        train.enum_wagons do |wagon, i| 
          if wagon.class == CargoWagon 
            puts "#{i} - Тип вагона: #{wagon.class}, вместимость: #{wagon.volume} из них свободно #{wagon.free_space} "
          elsif wagon.class == PassengerWagon
            puts "#{i} - Тип вагона: #{wagon.class}, вместимость: #{wagon.passenger_seats.length} из них занято #{wagon.number_of_occupied_seats} "
          end
        end
      end
    end  
  end

  def create_wagon
    puts 'Грузовой или пассажирский? (cargo / passenger)'
    answer = gets.chomp 
    if answer == 'cargo'
      puts 'Введите объем: '
      @wagons << CargoWagon.new(gets.to_i)
    elsif answer == 'passenger'
      puts 'Введите количество мест: '
      @wagons << PassengerWagon.new(gets.to_i)
    else
      raise 'Введено некорректное значение!'
    end 
  end

  def fill_wagon
    train = select_train
    puts 'Выберите вагон: '
    train.wagons.each.with_index(1) {|wagon, i| puts "#{i} - #{wagon.class}"}
    wagon = train.wagons[gets.to_i - 1]
    if wagon.class == CargoWagon
      puts "Введите количество: "
      quantity = gets.to_i
      wagon.filling(quantity)
    elsif wagon.class == PassengerWagon
      wagon.take_seat
    end
    puts "Готово!"
  end  

end
