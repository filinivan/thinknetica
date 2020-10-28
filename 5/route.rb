class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]      # Если сделать @stations << [first, last] то ругается (undefined method `<<' for nil:NilClass)
  end 

  def station_add(station)
    @stations.insert(-2, station)
  end

  def station_del(station)
    @stations.delete(station)
  end 

  def station_list
    @stations.each { |station| puts station }
  end 
end 
