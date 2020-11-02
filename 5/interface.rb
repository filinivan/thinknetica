class Interface
  
  def initialize
    @trains = []
    @routes = []
    @stations = []
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
      puts '0 Для выхода'
      puts 'Выберите пункт: '

      input = gets.chomp.to_i

      if input == 1
        create_new_station
      elsif input == 2
        create_new_train
      elsif input == 3
        create_new_route
      elsif input == 4
        control_route
      elsif input == 5
        set_route
      elsif input == 6
        wagons_hook
      elsif input == 7
        wagons_unhook
      elsif input == 8
        control_train
      elsif input == 9
        show_stations
      elsif input == 10
        show_station_trains
      elsif input == 0
        break
      else
        puts 'Неверное значение!'
      end 
    end
  end

  private

  def create_new_station
    print 'Введите название станции: '
    name = gets.chomp
    @stations << Station.new(name)
  end

  def create_new_train
    puts "Создаётся грузовой поезд? yes/no"
    cargo = gets.chomp
    print 'Введите номер поезда '
    number = gets.chomp.to_i
    if cargo == 'yes'
      @trains << TrainCargo.new(number)
    else
      @trains << TrainPassenger.new(number)
    end
  end

  def create_new_route
    i = 1
    @stations.each do |station|
      puts "#{i} - #{station.name}"
      i += 1
    end 
    puts 'Укажите начальную станцию '
    first = gets.to_i - 1
    puts 'Укажите конечную станцию '
    last = gets.to_i - 1
    route = Route.new(@stations[first], @stations[last])
    @routes << route
    puts "Создан маршрут #{route.name}"
  end

  def control_route
    puts 'Выберите маршрут'
    show_routes
    route = @routes[gets.to_i - 1]
    puts "Выбран маршрут #{route.name}"
    puts "1. Добавить станцию\n2. Удалить станцию"
    answer = gets.chomp
    if answer == '1'
      puts 'Какую станцию добавить в маршрут?'
      route.station_list
      route.station_add(@stations[gets.to_i - 1])
      puts 'Станция успешно добавлена'
    elsif answer =='2'
      puts 'Какую станцию вы хотите удалть из маршрута?'
      route.station_list
      route.station_del(route.stations[gets.to_i - 1])
      puts 'Станция успешно добавлена'
    end
  end

  def set_route
    train = select_train

    puts 'Выберите маршрут'
    show_routes
    train.set_route(@routes[gets.to_i - 1])
    puts "Маршрут поезду #{train.number} успешно указан"
  end

  def wagons_hook
    train = select_train
    print 'Сколько вагонов вы хотите добавить: '
    quantity = gets.to_i
    if train.class == TrainPassenger
      quantity.times do
        train.wagons_hook(PassengerWagon.new)
      end
    else
      quantity.times do
        train.wagons_hook(CargoWagon.new)
      end
    end
    puts "К поезду #{train.number} было добавлено #{quantity} вагонов"
  end

  def wagons_unhook
    train = select_train
    print 'Сколько вагонов вы хотите отцепить: '
    quantity = gets.to_i
    quantity.times do
      train.wagons_unhook
    end
    puts "С поезда #{train.number} было отцеплено #{quantity} вагонов"
  end

  def control_train
    train = select_train

    puts "Отправить поезд #{train.number} на станцию\n1. Следующую\n2. Предыдущую"
    case gets.chomp
    when '1'
      train.move_forvard
    when '2'
      train.move_back
    end
    puts "Поезд на станции:  #{train.current_station.name}"
  end

  def select_train
    puts 'Выберите поезд'
    trains
    train = @trains[gets.to_i - 1]
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

  def show_station_trains
    puts 'Выберите станцию'
    show_stations
    station = @stations[gets.to_i - 1]
    station.show_all
  end
end
