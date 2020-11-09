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
      when 0
        break
      else
        puts 'Неверное значение!'
      end 
    end
  end

  private

  def create_new_station
    puts 'Введите название станции: '
    name = gets.chomp
    @stations << Station.new(name)
  end

  def create_new_train
    begin
      cargo = gets.chomp
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
    # i = 1
    @stations.each.with_index(1) do |station, i|
      puts "#{i} - #{station.name}"
      # i += 1
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
    puts 'Введите количество вагонов: '
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
  end

  def wagons_unhook
    train = select_train
    puts 'Введите количество вагонов: '
    quantity = gets.to_i
    quantity.times do
      train.wagons_unhook
    end
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
end
