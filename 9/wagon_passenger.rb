class PassengerWagon
  attr_reader :passenger_seats

  def initialize(places)
    @passenger_seats = Array.new(places, 0)
  end

  def take_seat
    @passenger_seats.any?(0) ? @passenger_seats[0] = 1 : raise('Нет свободных мест!')
    @passenger_seats.sort
  end

  def number_of_occupied_seats
    @passenger_seats.count(1)
  end
end
