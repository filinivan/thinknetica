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

  def number_of_trains_by_type(type)
    quantity = 0
    @trains.each do |train|
      quantity += 1 if train.type == type
    end
    puts quantity
  end
end
