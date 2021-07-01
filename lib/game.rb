# frozen_string_literal true

require_relative 'board'
require_relative 'display'

class Game
  attr_accessor :player_one, :player_two

  include Display

  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
    @current_player = nil
  end

  def start_game
    loop do
      puts welcome_msg
      set_players_names
      game_play
      break if player_quit
    end
  end

  def player_quit
    key = ' '
    until 'yn'.include?(key)
      puts 'do you want to play again?  y/n'
      key = gets.chomp
    end
    return true if key == 'q'
    false
  end

  def set_players_names
    @player_one = player_name_setter(1)
    puts created_player_msg(@player_one)
    @player_two = player_name_setter(2)
    puts created_player_msg(@player_two)
  end

  def player_name_setter(player_number)
    loop do
      puts insert_player_name_msg(player_number)
      player_name = gets.chomp

      return player_name if player_name != ''
    end
  end

  private

  def game_play
    @current_player = @player_one

    loop do
      break if @board.winner? || @board.full?

      player_turn(@current_player)
      @current_player = @current_player == @player_one ? @player_two : @player_one
    end

    @current_player = @current_player == @player_one ? @player_two : @player_one

    if @board.winner?

      game_won(@current_player)
    else
      game_full
    end
  end

  def player_turn(player)
    puts player_turn_msg(player)
    display_board(@board.content)
    place_chosed = player_choose
    player_movement_to_board(player, place_chosed)
  end

  def player_choose
    key = gets.chomp.to_i - 1
    key = gets.chomp.to_i - 1 until valid_key?(key)
    key
  end

  def valid_key?(key)
    if key.between?(0, 6) && !@board.column_full?(key)
      true
    else
      puts display_invalid_move
      puts player_turn_msg(@current_player)
      false
    end
  end

  def player_movement_to_board(player, place)
    player == @player_one ? @board.player_move(place, '1') : @board.player_move(place, '2')
  end

  def game_won(player)
    puts "Four in a row! Congratulations, #{player}! "
    display_board(@board.content)
  end

  def game_full
  end
end
