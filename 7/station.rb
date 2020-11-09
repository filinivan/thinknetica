class Station
  attr_reader :name, :trains
  # @@stations = []
  include InstanceCounter
  STATION_NAME = /[[:upper:]]+[[:lower:]]/

  def initialize(name)
    @name = name
    @trains = []
    # @@stations << self
    register_instance
    validate!
  end

  # def self.all
  #   @@stations.each.with_index(1) {|station, x| puts "#{x} - #{station.name}"}
  # end

  def add_train(train)
    @trains << train
  end  

  def del_train(train)
    @trains.delete(train)
  end 
  
  protected

  def validate!
    raise 'Invalid station name' if name !~ STATION_NAME
  end
end
