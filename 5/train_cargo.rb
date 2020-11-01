class TrainCargo < Train 
  def wagons_hook(wagon)
    if wagon.class == CargoWagon
    @wagons << wagon if @speed == 0
    else
      puts "Incorrect wagon type"
    end  
  end 
end

