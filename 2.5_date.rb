puts "Введите число: "
day = gets.chomp.to_i
puts "Введите месяц: "
month = gets.chomp.to_i - 1 
puts "Введите год: "
year = gets.chomp.to_i

#Массив количества дней для не високосного года
arr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

#Определяем високосный год или нет
if year % 4 == 0 || (year % 100 != 0 && year % 400 == 0)
  arr[1] = 29
end

#Цикл подсчёта количества дней
# 0.upto(month) do |i|
#   day += arr[i]
#   i += 1
# end

day += arr.take(month).sum 

puts day
