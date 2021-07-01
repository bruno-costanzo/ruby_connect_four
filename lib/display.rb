# frozen_string_literal: true

module Display
  OPEN = "\u26AB "
  RED_CHIP = "\u{1F534} "
  BLUE_CHIP = "\u{1F535} "

  def welcome_msg
    'Welcome to Connect Four Game!'
  end

  def insert_player_name_msg(number)
    "Please, insert name for Player ##{number}"
  end

  def created_player_msg(player)
    "Succesfully created, player #{player}"
  end

  def display_board(board_rows)
    print " 1  2  3  4  5  6  7 \n"
    board_rows.each do |row|
      row.each do |item|
        print OPEN if item == ''
        print RED_CHIP if item == '1'
        print BLUE_CHIP if item == '2'
      end
      print "\n"
    end
  end

  def player_turn_msg(player)
    "Please, #{player}, pick a number to put a chip on the board"
  end

  def display_invalid_move
    "Your move is not valid. The number must be between 1 and 7 and the column must not be full."
  end
end
