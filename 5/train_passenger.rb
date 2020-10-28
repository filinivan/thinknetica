class TrainPassenger < Train 
  def wagons_hook(wagon)
    if wagon.type == 'passenger'
      super
    else
      puts "Incorrect wagon type"
    end  
  end 

  def wagons_unhook(wagon)
    if wagon.type == 'passenger'
      super
    else
      puts "Incorrect wagon type"
    end 
  end
end
