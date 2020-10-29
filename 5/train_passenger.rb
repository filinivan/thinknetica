class TrainPassenger < Train 
  def wagons_hook(wagon)
    if wagon.class == 'PassengerWagon'
      super
    else
      puts "Incorrect wagon type"
    end  
  end 

  def wagons_unhook(wagon)
    if wagon.type == 'PassengerWagon'
      super
    else
      puts "Incorrect wagon type"
    end 
  end
end

# train2 = TrainPassenger.new(555)
