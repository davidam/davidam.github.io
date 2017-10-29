
def mod_zero(x, y)
  return (0 == (x % y))
end

def generate_l(x, y)
  if (x == y)
    return [x]
  else
    return [x] + generate_l(x+1, y)
  end
end

def dividers(x)
  l = generate_l(1, x)
  list = []
  l.each do |i|
    if mod_zero(x, i)
      list = list + [i]
    end
  end
  return list
end

def primes(x)
  l = generate_l(1, x)
  list = []
  l.each do |i|
    d = dividers(i)
    if (d.length == 2 || i == 1)
      list = list + [i]
    end
  end
  return list
end

puts "Give me a number: "
x = gets.chomp()
puts "The primes list until #{x} is "
puts primes(x)
