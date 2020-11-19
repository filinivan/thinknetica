class Station
  attr_reader :name, :trains

  include InstanceCounter
  STATION_NAME = /[[:upper:]]+[[:lower:]]/.freeze

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    validate!
  end

  def add_train(train)
    @trains << train
  end

  def del_train(train)
    @trains.delete(train)
  end

  def enum_trains
    @trains.each do |train|
      yield(train)
    end
  end

  protected

  # def validate!
  #   raise 'Invalid station name' if name !~ STATION_NAME
  # end
end
