arr = []
fib1 = 1
fib2 = 0

# while fib1 < 100 do
#   fib_sum = fib1 + fib2
#   fib1 = fib2
#   fib2 = fib_sum
#   arr << fib1 if fib1 < 100
# end

begin
  fib_sum = fib1 + fib2
  fib1 = fib2
  fib2 = fib_sum
  arr << fib1 
end while fib1 < 89 #Пока вижу только один способ обойтись одним условием - понизить проверочное число.
                    #Ну, еще я только-что узнал новую конструкицю с условием в конце. Решил применить. 
puts arr
