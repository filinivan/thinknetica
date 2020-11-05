class Station
  attr_reader :name, :trains
  @@stations = []
  include InstanceCounter

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations.each.with_index(1) {|station, x| puts "#{x} - #{station.name}"}
  end

  def add_train(train)
    @trains << train
  end  

  def del_train(train)
    @trains.delete(train)
  end 

  def show_all
    @trains.each {|train| puts "#{train.number} - #{train.class}"}
  end

  def trains_by_type(type)
    @trains.each do |train|
      puts train if train.class.to_s == type
    end 
  end

end
