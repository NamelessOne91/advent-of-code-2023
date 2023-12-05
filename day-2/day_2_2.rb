script_directory = File.dirname(__FILE__)
file_name = 'input.txt'
file_path = File.join(script_directory, file_name)

power_sets_sum = 0

def parse_game_results(results)
  min_cubes = {
    'green' => 0,
    'red' => 0,
    'blue' => 0
  }

  results.split(': ')[1].gsub(';', ',').split(', ') do |cubes|
    number, color = cubes.split(' ')
    value = number.to_i

    min_cubes[color] = value if value > min_cubes[color]
  end

  min_cubes.values.reduce(1) { |accumulator, number| accumulator * number }
end

File.foreach(file_path) do |line|
  power_sets_sum += parse_game_results(line)
end

puts "Power sets sum: #{power_sets_sum}"
