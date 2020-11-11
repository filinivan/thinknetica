class PassengerWagon
  attr_reader :passenger_seats 
  @@wagons = []
  def initialize(places)
    @passenger_seats = Array.new(places, 0)
    @@wagons << self
  end

  def take_seat
    if @passenger_seats.any?(0)
      @passenger_seats[0] = 1
      @passenger_seats.sort
    else
      raise 'Нет свободных мест!'
    end
  end

  def number_of_occupied_seats
    @passenger_seats.count(1)
  end 

  # def number_of_seats
  #   @passenger_seats.length  
  # end

end


