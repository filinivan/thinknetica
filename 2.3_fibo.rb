arr = []
fib1 = 1
fib2 = 0

while fib1 < 100 do
  fib_sum = fib1 + fib2
  fib1 = fib2
  fib2 = fib_sum
  arr << fib1 if fib1 < 100
end

puts arr