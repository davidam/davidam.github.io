# coding: utf-8

def fibonacci(x)
  if (x == 0) || (x == 1)
    return 1
  else
    return  fibonacci(x - 1) + fibonacci(x - 2)
  end
end

puts "Dame un número y te devuelvo el número de fibonacci: \n"
x = gets.chomp().to_i
puts fibonacci(x)
