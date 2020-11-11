class CargoWagon
attr_reader :fill, :wagons, :volume
@@wagons = []
  def initialize(volume)
    @volume = volume 
    @fill = 0
    @@wagons << self
  end

  def filling(quantity)
    if @volume >= @fill+quantity
      @fill += quantity
    else
      raise 'Недостаточно места!'
    end
  end

  def free_space
    @volume - @fill
  end
end


