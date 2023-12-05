script_directory = File.dirname(__FILE__)
file_name = 'input.txt'
file_path = File.join(script_directory, file_name)

$lines = File.readlines(file_path)
num_lines = $lines.size
line_length = $lines[0].size - 1 # beware of \n

DIRECTIONS = [
  [-1, -1], [0, -1], [1, -1],
  [-1,  0],          [1, 0],
  [-1,  1], [0, 1], [1, 1]
].freeze

def symbol?(char)
  !char.match?(/\d|\./)
end

def inside?(line_length, lines_length, coord)
  x, y = coord
  x >= 0 && x < line_length && y >= 0 && y < lines_length
end

def find_number_and_coords(lines)
  numbers = []
  coords = []

  lines.each_with_index do |line, y|
    cur_digits = ''
    cur_coords = []

    line.each_char.with_index do |c, x|
      if c.match?(/\d/)
        cur_digits += c
        cur_coords << [x, y]
      elsif !cur_digits.empty?
        numbers << cur_digits.to_i
        cur_digits = ''
        coords << cur_coords
        cur_coords = []
      end
    end

    unless cur_digits.empty?
      numbers << cur_digits.to_i
      coords << cur_coords
    end
  end

  [numbers, coords]
end

def part_number?(coords, line_length, num_lines)
  coords.each do |coord|
    DIRECTIONS.each do |direction|
      fx = (coord[0] + direction[0])
      fy = (coord[1] + direction[1])
      return true if inside?(line_length, num_lines, [fx, fy]) && symbol?($lines[fy][fx])
    end
  end

  false
end

numbers, coords = find_number_and_coords($lines)

total = 0
numbers.each_index do |i|
  total += numbers[i] if part_number?(coords[i], line_length, num_lines)
end
puts "Part numbers sum: #{total}"
