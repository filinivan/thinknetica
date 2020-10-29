class TrainCargo < Train 
  def wagons_hook(wagon)
    if wagon.class == 'CargoWagon'
      super
    else
      puts "Incorrect wagon type"
    end  
  end 

  def wagons_unhook(wagon)
    if wagon.class == 'CargoWagon'
      super
    else
      puts "Incorrect wagon type"
    end 
  end
end

# train1 = TrainCargo.new(666)
