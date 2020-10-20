puts "Введите ваше имя"
name = gets.chomp
puts "Введите ваш рост:"
height = gets.chomp.to_i
puts "#{name.capitalize}, твой идеальный вес= #{(height - 110) * 1.15}"