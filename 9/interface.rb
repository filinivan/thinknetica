class Interface
  def initialize
    @trains = []
    @routes = []
    @stations = []
    @wagons = []
    @menu = %w[Создать_станцию Создать_поезд Создать_маршрут Управлять_маршрутом
               Установить_маршрут Прицепить_вагон Отцепить_вагон Двигать_поезд_по_маршруту
               Все_станции_на_маршруте Показать_все_поезда_на_станции Создать_вагон
               Показать_информацию_по_всем_поездам Заполнить_вагон Выход]
  end

  def start
    loop do
      @menu.each.with_index(1) { |item, i| puts "#{i} - #{item}" }

      input = gets.to_i

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
      when 14
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
    puts 'Поезд грузовой? y/n'
    cargo = gets.chomp
    puts 'Введите номер поезда в формате ХХХ-ХХ или ХХХХХ'
    number = gets.chomp
    @trains << (cargo == 'y' ? TrainCargo.new(number) : TrainPassenger.new(number))
  rescue RuntimeError => e
    puts e.message
    retry
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
    puts '1 - Добавить станцию. 2 - Удалить станцию'
    answer = gets.to_i
    case answer
    when 1
      route.station_list
      route.station_add(@stations[gets.to_i - 1])
    when 2
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
    @wagons.each.with_index(1) { |wagon, i| puts "#{i} - #{wagon.class}" }
    wagon = @wagons[gets.to_i - 1]
    if train.instance_of?(TrainPassenger) && wagon.instance_of?(PassengerWagon)
      train.wagons_hook(wagon)
      @wagons.delete(wagon)
    elsif train.instance_of?(TrainCargo) && wagon.instance_of?(CargoWagon)
      train.wagons_hook(wagon)
      @wagons.delete(wagon)
    end
  end

  def wagons_unhook
    train = select_train
    puts 'Выберите вагон: '
    train.wagons.each.with_index(1) { |wagon, i| puts "#{i} - #{wagon.class}" }
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
    # train = @trains[gets.to_i - 1]
    @trains[gets.to_i - 1]
  end

  def select_wagon
    puts 'Выберите вагон: '
    @wagons.each.with_index(1) { |wagon, i| puts "#{i} - #{wagon.class}" }
    @wagons[gets.to_i - 1]
  end

  def trains
    @trains.each.with_index(1) do |train, x|
      puts "#{x}. #{train.number} | вагонов:  #{train.wagons.size} | класс #{train.class}"
    end
  end

  def show_routes
    @routes.each.with_index(1) { |route, x| puts "#{x}. #{route.name}" }
  end

  def show_stations
    @stations.each.with_index(1) do |station, x|
      puts "#{x}. #{station.name} | поездов #{station.trains.size}"
    end
  end

  def show_stations_on_route
    puts 'Укажите маршрут: '
    @routes.each.with_index(1) { |route, i| puts "#{i} - #{route.name}" }
    route = @routes[gets.to_i - 1]
    route.stations.each { |station| puts station.name }
  end

  def show_station_trains
    show_stations
    station = @stations[gets.to_i - 1]
    station.trains.each { |train| puts "#{train.number} - #{train.class}" }
  end

  def all_trains
    @stations.each do |station|
      puts "#{station.name} ......................"
      station.enum_trains do |train|
        puts "Номер: #{train.number}, тип: #{train.class}, кол-во вагонов: #{train.wagons.length} "
        train.enum_wagons do |wagon, i|
          if wagon.instance_of?(CargoWagon)
            puts "#{i} - Тип вагона: #{wagon.class}, вместимость: #{wagon.volume} \
из них свободно #{wagon.free_space} "
          elsif wagon.instance_of?(PassengerWagon)
            puts "#{i} - Тип : #{wagon.class}, вместимость: #{wagon.passenger_seats.length} \
Занято #{wagon.number_of_occupied_seats} "
          end
        end
      end
    end
  end

  def create_wagon
    puts 'Грузовой или пассажирский? (cargo / passenger)'
    answer = gets.chomp
    case answer
    when 'cargo'
      puts 'Введите объем: '
      @wagons << CargoWagon.new(gets.to_i)
    when 'passenger'
      puts 'Введите количество мест: '
      @wagons << PassengerWagon.new(gets.to_i)
    else
      raise 'Введено некорректное значение!'
    end
  end

  def fill_wagon
    train = select_train
    puts 'Выберите вагон: '
    train.wagons.each.with_index(1) { |wagon, i| puts "#{i} - #{wagon.class}" }
    wagon = train.wagons[gets.to_i - 1]
    if wagon.instance_of?(CargoWagon)
      puts 'Введите количество: '
      quantity = gets.to_i
      wagon.filling(quantity)
    elsif wagon.instance_of?(PassengerWagon)
      wagon.take_seat
    end
    puts 'Готово!'
  end
end
