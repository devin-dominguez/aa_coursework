class Player

  def get_input_coords
    formated_properly = false
    # !while
    until formated_properly
      puts "Enter coordinates (row, col)"
      coords = gets.chomp.split(',').take(2)
      formated_properly = coords_properly_formated?(coords)
    end

    coords.map(&:to_i)
  end

  def get_input_action
    proper_action = false
    #!while
    until proper_action
      puts "(f)lag or (r)eveal?"
      action_str = gets.chomp
      proper_action = extract_action(action_str)
    end
    
    proper_action
  end

  def extract_action(action_str)
    index = action_str =~ /[fF]|[rR]/
    # !if
    return nil if index.nil?
    action_str[index].downcase
  end

  def coords_properly_formated?(coords)
    coords.length == 2
  end

end
