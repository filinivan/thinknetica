puts "Введите ваше имя"
name = gets.capitalize.chomp
puts "Введите ваш рост:"
height = gets.chomp.to_i
puts "#{name}, твой идеальный вес= #{(height - 110) * 1.15}"