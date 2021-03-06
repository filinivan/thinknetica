order = {}
product = 'Empty'
cart = 0.0

loop do 
  puts 'Введите название товара: '
  product = gets.chomp.downcase
  break if product == 'стоп'

  puts 'Введите цену: '
  price = gets.chomp.to_f

  puts 'Введите количество: '
  product_quantity = gets.chomp.to_i

  order[product] = { cost: price, quantity: product_quantity } 
end

order.each_pair do |key, value|
  summ = value[:cost] * value[:quantity]
  cart += summ
  puts "#{key} = #{summ}"
end

puts order
puts "Стоимость всех товаров : #{cart}"
