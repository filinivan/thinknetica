puts 'Сторона 1'
a = gets.chomp.to_i
puts 'Сторона 2'
b = gets.chomp.to_i
puts 'Сторона 3'
c = gets.chomp.to_i


if a**2 == (b**2) + (c**2) || b**2 == (a**2) + (c**2) || c**2 == (a**2) + (b**2)
	rectangular = true
else 
	rectangular = false	
end

if a == b && b == c
	isosceles = true
else 
	isosceles = false	
end

if rectangular 
	print 'Треугольник является: прямоугольным, '
else 
	print 'Треугольник является: не прямоугольным, '
end 


if isosceles
	puts 'равнобедренным'
else
	puts 'не равнобедренным'
end

