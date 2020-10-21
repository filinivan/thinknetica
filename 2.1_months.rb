months = {jan: 31, feb: 29, mar: 31, 
          apr: 30, may: 31, jun: 30, 
          jul: 31, aug: 31, sent: 30,
          okt: 31, nov: 30, dec: 31}

months.each do |key, value|
  puts key if value == 30
end