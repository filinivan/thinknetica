class Station
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end  

  def del_train(train)
    @trains.delete(train)
  end 

  def show_all
    @trains.each {|train| puts "#{train.number} - #{train.class}"}
  end

  def trains_by_type(type)
    @trains.each do |train|
      puts train if train.class.to_s == type
    end 
  end
end
