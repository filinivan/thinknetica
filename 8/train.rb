class Train 
  attr_reader :number, :speed, :wagons, :current_station
  include Company
  include InstanceCounter
  include Valid
  TRAIN_NUMBER_FORMAT = /^[[:alnum:]]{3}\-?[[:alnum:]]{2}$/
  @@trains = {}

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @@trains[self.number] = self
    register_instance
  end 

  def self.find(number)
    @@trains[number]
  end

  def speed_up(speed)   
    @speed += speed
  end 

  def speed_down          
    loop do 
      @speed -= 1         
      break if speed == 0
    end 
  end 

  def set_route(route)      
    @route = route
    @current_station_index = 0               
    @current_station = @route.stations[@current_station_index]
    @current_station.add_train(self)
  end

  def move_forvard 
    @current_station.del_train(self)
    @current_station = @route.stations[@current_station_index += 1]
    @current_station.add_train(self)
  end

  def move_back 
    @current_station = @route.stations[@current_station_index -= 1]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end 

  def wagons_unhook
    @wagons.delete_at(0) if @speed == 0
  end


  protected

  def validate!
      raise 'Invalid format of number! Please use format XXX-XX or XXXXX' if @number !~ TRAIN_NUMBER_FORMAT
  end

end 


