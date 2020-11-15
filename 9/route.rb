class Route
  attr_reader :stations, :name

  include InstanceCounter

  def initialize(first, last)
    @name = "#{first.name} - #{last.name}"
    @stations = [first, last]
    register_instance
  end

  def station_add(station)
    @stations.insert(-2, station)
  end

  def station_del(station)
    @stations.delete(station)
  end

  def station_list
    @stations.each { |station| puts station.name }
  end
end
