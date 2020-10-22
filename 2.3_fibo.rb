arr = []
fib1 = 1
fib2 = 0

loop do
  fib_sum = fib1 + fib2
  fib1 = fib2

  break if fib1 > 100

  fib2 = fib_sum
  arr << fib1 
end
puts arr
