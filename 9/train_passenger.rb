class TrainPassenger < Train
  def wagons_hook(wagon)
    @wagons << wagon if @speed.zero? && wagon.instance_of?(PassengerWagon)
  end
end
