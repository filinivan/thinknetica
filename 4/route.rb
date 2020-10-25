class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = []
    @stations << [first, last]
  end 

  def station_add(station)
    @stations.insert(-2, station)
  end

  def station_del(name)
    @stations.delete(name)
  end 

  def station_list
    @stations.each { |station| puts station }
  end 
end 
