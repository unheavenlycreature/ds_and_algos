# frozen_string_literal: true

MIN_POS = 0
MAX_POS = 7

def knight_moves(start_pos, end_pos)
  move_queue = [start_pos]
  parents = {}

  until move_queue.empty?
    current = move_queue.shift
    if current == end_pos
      print_path(start_pos, current, parents)
      return
    end

    adjacent_spaces(current).each do |adjacent|
      next if parents.keys.include? adjacent

      parents[adjacent] = current
      move_queue << adjacent
    end
  end
end

def print_path(start_pos, current, parents)
  path = get_path(start_pos, current, parents)
  puts "You made it in #{path.length - 1} moves!"
  path.each { |space| print "#{space}\n" }
end

def get_path(start_pos, current, parents)
  reversed_path = [current]
  until parents[current] == start_pos
    parent = parents[current]
    reversed_path << parent
    current = parent
  end
  reversed_path << start_pos
  reversed_path.reverse
end

def adjacent_spaces(pos)
  spaces = []
  # Right two, forward one.
  spaces << [pos[0] + 2, pos[1] + 1] if pos[0] + 2 <= MAX_POS && pos[1] + 1 <= MAX_POS

  # Right two, back one.
  spaces << [pos[0] + 2, pos[1] - 1] if pos[0] + 2 <= MAX_POS && pos[1] - 1 >= MIN_POS
  
  # Right one, forward two.
  spaces << [pos[0] + 1, pos[1] + 2] if pos[0] + 1 <= MAX_POS && pos[1] + 2 <= MAX_POS

  # Right one, back two.
  spaces << [pos[0] + 1, pos[1] - 2] if pos[0] + 1 <= MAX_POS && pos[1] - 2 >= MIN_POS

  # Left two, back one.
  spaces << [pos[0] - 2, pos[1] - 1] if pos[0] - 2 >= MIN_POS && pos[1] - 1 >= MIN_POS

  # Left two, forward one.
  spaces << [pos[0] - 2, pos[1] + 1] if pos[0] - 2 >= MIN_POS && pos[1] + 1 <= MAX_POS

  # Left one, back two.
  spaces << [pos[0] - 1, pos[1] - 2] if pos[0] - 1 >= MIN_POS && pos[1] - 2 >= MIN_POS

  # Left one, forward two.
  spaces << [pos[0] - 1, pos[1] + 2] if pos[0] - 1 >= MIN_POS && pos[1] + 2 <= MAX_POS

  spaces
end

knight_moves([3,3],[0,0])