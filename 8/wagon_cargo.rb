class CargoWagon
attr_reader :fill

  def initialize(volume)
    @volume = volume 
    @fill = 0
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
  endf
end


