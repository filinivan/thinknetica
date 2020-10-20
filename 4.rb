puts 'Коэффициент 1'
a = gets.chomp.to_i
puts 'Коэффициент 2'
b = gets.chomp.to_i
puts 'Коэффициент 3'
c = gets.chomp.to_i

d = (b**2) - 4*a*c 

if d < 0
    puts "Корней нет"
elsif d == 0
    root = (-b + Math.sqrt(d)) / (2 * a)
    puts "Дискриминант : #{d}. Корень : #{root}"
else
    disc = Math.sqrt(d)
    root1 = (-b + disc) / (2 * a)
    root2 = (-b - disc) / (2 * a)
    puts "Дискриминант : #{d}. Первый корень : #{root1}, второй корень : #{root2}"
end