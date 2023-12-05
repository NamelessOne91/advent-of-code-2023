script_directory = File.dirname(__FILE__)
file_name = 'input.txt'
file_path = File.join(script_directory, file_name)

total = 0
File.foreach(file_path) do |line|
  first_digit = line.each_char.find { |char| char.match(/\d/) }
  last_digit = line.reverse.each_char.find { |char| char.match(/\d/) }

  value = "#{first_digit}#{last_digit}"
  total += value.to_i
end

puts total
