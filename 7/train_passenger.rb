class TrainPassenger < Train 
  def wagons_hook(wagon)
    if wagon.class == PassengerWagon
      @wagons << wagon if @speed == 0
    else
      puts "Incorrect wagon type"
    end  
  end 

end


