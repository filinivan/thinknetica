hash = {}
alphabet = ('а'..'я').to_a #Генерация не включает букву "ё". Если её наличие принципиально - массив придётся заполнить руками.
vowel = ['а', 'у', 'о', 'ы', 'и', 'э', 'я', 'ю', 'ё', 'е',]

alphabet.each.with_index(1) do |w, index|
  hash[w] = index if vowel.include?(w)
end

puts hash
