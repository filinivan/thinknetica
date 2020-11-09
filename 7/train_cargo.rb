class TrainCargo < Train 
  def wagons_hook(wagon)
    @wagons << wagon if @speed == 0 && wagon.class == CargoWagon
  end 
end

