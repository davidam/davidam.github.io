# coding: utf-8

def factorial(x)
  if (x <= 0)
    return 1
  else 
    return x * factorial(x - 1)
  end
end

puts "Escribe un número y devuelvo el factorial de ese número: \n"
num = gets.chomp().to_i
puts factorial(num)

