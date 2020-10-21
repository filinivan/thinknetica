hash = {}
alphabet = ('а'..'я').to_a #Генерация не включает букву "ё". Если её наличие принципиально - массив придётся заполнить руками.
vowel = ['а', 'у', 'о', 'ы', 'и', 'э', 'я', 'ю', 'ё', 'е',]

alphabet.each do |w|
  if vowel.include?(w)
    hash[w] = alphabet.index(w)
  end
end

puts hash