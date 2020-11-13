class CargoWagon
  attr_reader :fill, :wagons, :volume

  def initialize(volume)
    @volume = volume
    @fill = 0
  end

  def filling(quantity)
    @volume >= @fill + quantity ? @fill += quantity : raise('Недостаточно места!')
  end

  def free_space
    @volume - @fill
  end
end
