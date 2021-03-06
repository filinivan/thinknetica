class Station
  attr_reader :name
  
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
    @trains.each {|train| puts train}
  end

  def number_of_trains_by_type(type)
    quantity = @trains.count {|item| item.type == type}
    puts quantity
  end
end
