def elimDobles(list)
  if (list.length == 0)
    list
  else
    rest = []
    list[1..-1].each do |a|
      if (a != list[0])
        rest = rest + [a]
      end
    end
    [list[0]] + elimDobles(rest)
  end
end

print elimDobles([1, 2, 2, 1, 1, 3])
