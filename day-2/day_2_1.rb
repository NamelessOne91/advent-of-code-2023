script_directory = File.dirname(__FILE__)
file_name = 'input.txt'
file_path = File.join(script_directory, file_name)

THRESHOLD = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}.freeze


ids_sum = 0
def parse_game_results(results)
  id = results.match(/Game (\d+):/)[1]

  results.split(': ')[1].gsub(';', ',').split(', ') do |cubes|
    number, color = cubes.split(' ')
    value = number.to_i
    return 0 unless value <= THRESHOLD[color]
  end

  id.to_i
end

File.foreach(file_path) do |line|
  ids_sum += parse_game_results(line)
end

puts "IDs sum: #{ids_sum}"

