# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }
  let(:player_one) { 'bruno' }
  let(:player_two) { 'jimmy' }

  describe '#start_game' do
    it 'send welcome msg, creates two players and start game logic' do
      allow(game).to receive(:puts).once
      allow(game).to receive(:welcome_msg)
      expect(game).to receive(:set_players_names)
      expect(game).to receive(:game_play)
      game.start_game
    end
  end

  describe '#set_players_names' do
    before do
      first_player = 'bruno'
      second_player = 'jimmy'
      allow(game).to receive(:player_name_setter).and_return(first_player, second_player)
    end
    it 'calls player_name_setter and asign responses to player_one and player_two' do
      expect(game).to receive(:player_name_setter).once.with(1)
      expect(game).to receive(:puts).twice
      expect(game).to receive(:created_player_msg).twice
      expect(game).to receive(:player_name_setter).once.with(2)
      game.set_players_names
      expect(game.player_one).to eq('bruno')
    end
  end

  describe '#player_name_setter' do
    before do
      invalid_player_name = ''
      first_player_name = player_one
      allow(game).to receive(:gets).and_return(invalid_player_name, first_player_name)
      allow(game).to receive(:puts)
    end

    it 'receives the player number and set a string to the player_(number) variable' do
      expect(game).to receive(:insert_player_name_msg).twice.with(1)
      response = game.player_name_setter(1)
      expect(response).to eq('bruno')
    end
  end
end
