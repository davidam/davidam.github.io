# coding: utf-8
def hanoi(x)
  if (x <= 0) 
    return 0
  elsif (x == 1)
    return 1
  else
    return 1 + 2 * hanoi(x - 1)
  end
end

puts "Escribe un número y te digo cuantos movimientos necesitas para ganar en el juego de torres de hanoi: \n"
num = gets.chomp().to_i
puts hanoi(num)


