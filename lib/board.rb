# frozen_string_literal: true

# The board has the information about were the players are putting their coins
class Board
  DIAGONASLS = [[[2, 0], [3, 1], [4, 2], [5, 3]], [[1, 0], [2, 1], [3, 2], [4, 3], [5, 4]], [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5]], [[0,1], [1, 2], [2, 3], [3, 4], [5, 6], [5, 6]], [[0, 2], [1, 3], [2, 4], [3, 5], [4, 6]], [[0, 3], [1, 4], [2, 5], [3, 6]], [[2, 6], [3, 5], [4, 4], [5, 3]], [[1, 6], [2, 5], [3, 4], [4, 3], [5, 2]], [[5, 1], [4, 2], [3, 3], [2, 4], [1, 5], [0, 6]], [[0, 5], [1, 4], [2, 3], [3, 2], [4, 1], [5, 0]], [[0, 4], [1, 3], [2, 2], [3, 1], [4, 0]], [[3, 0], [2, 1], [1, 2], [0, 3]]]

  attr_accessor :content

  def initialize
    @content = Array.new(6) { Array.new(7, '') }
  end

  def full?
    false
  end

  def player_move(place, player_number, last_slot = -1, chip_put: false)
    board_in_columns = @content.transpose
    until last_slot == -7 || chip_put == true
      if board_in_columns[place][last_slot] == ''
        board_in_columns[place][last_slot] = player_number
        chip_put = true
      else
        last_slot -= 1
      end
    end
    @content = board_in_columns.transpose
  end

  def column_full?(key)
    board_in_columns = @content.transpose
    board_in_columns[key].index('').nil?
  end

  def check_rows
    @content.each do |row|
      return true if row.join('').include?('1111') || row.join('').include?('2222')
    end
    false
  end

  def check_columns
    board_in_columns = @content.transpose
    board_in_columns.each do |column|
      return true if column.join('').include?('1111') || column.join('').include?('2222')
    end
    false
  end

  def check_diagonals
    row_array = []
    array_of_rows = []
    DIAGONASLS.each do |diagon|
      diagon.each do |value|
        row_array.push(@content[value[0]][value[1]])
      end
      array_of_rows << row_array
      row_array = []
    end
    array_of_rows.each do |diagonal|
      return true if diagonal.join('').include?('1111') || diagonal.join('').include?('2222')
    end
    false
  end

  def winner?
    check_rows || check_columns || check_diagonals
  end
end
