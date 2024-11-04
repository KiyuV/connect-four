# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#valid_move?' do
    subject(:game_move) { described_class.new }

    context 'When a player enters a valid move' do
      let(:player_input) { 3 }

      it 'returns true' do
        result = game_move.valid_move?(player_input)
        expect(result).to be true
      end
    end
    context 'When a player enetrs an invalid move' do
      let(:player_input) { 10 }

      it 'returns false' do
        result = game_move.valid_move?(player_input)
        expect(result).to be false
      end
    end
  end

  describe '#update_board' do
    subject(:game_update) { described_class.new }
    let(:player_input) { 3 }
    let(:player) { 2 }

    board_state = Array.new(7, -1)
    board = Array.new(7) { Array.new(6, ' ') }

    context 'When a valid input is entered' do
      before do
        game_update.update_board(player_input, player)
      end

      it 'updates the board state' do
        board_state[player_input] += 1

        result = game_update.instance_variable_get(:@board_state)
        expect(result).to eq board_state
      end

      it 'increments the number of tiles used' do
        tiles_used = 1

        result = game_update.instance_variable_get(:@tiles_used)
        expect(result).to eq tiles_used
      end

      it 'updates the board' do
        row = board_state[player_input]
        board[player_input][row] = 'X'

        result = game_update.instance_variable_get(:@board)
        expect(result).to eq board
      end
    end
  end

  describe '#board_full?' do
    subject(:game_board) { described_class.new }

    context 'When all the tiles are filled' do
      it 'returns true' do
        game_board.instance_variable_set(:@tiles_used, 42)

        result = game_board.board_full?
        expect(result).to be true
      end
    end
    context 'When there are still empty tiles' do
      it 'returns false' do
        game_board.instance_variable_set(:@tiles_used, 14)

        result = game_board.board_full?
        expect(result).to be false
      end
    end
  end

  describe '#game_over?' do
    subject(:game_finish) { described_class.new }
    let(:player_input) { 2 }

    context 'When the board does not result in a win' do
      let(:player) { 1 }

      before do
        board = Array.new(7) { Array.new(6, ' ') }
        board[1] = ['O', 'O', ' ', ' ', ' ', ' ']
        board[2] = ['X', 'X', 'X', 'O', ' ', ' ']

        board_state = Array.new(7, -1)
        board_state[player_input] = 3

        game_finish.instance_variable_set(:@board, board)
      end

      it 'returns false' do
        result = game_finish.game_over?(player_input, player)
        expect(result).to be false
      end
    end

    context 'When the board contains 4 in a row' do
      let(:player) { 2 }

      before do
        board = Array.new(7) { Array.new(6, ' ') }
        board[1] = ['O', 'O', 'O', ' ', ' ', ' ']
        board[2] = ['X', 'X', 'X', 'X', ' ', ' ']

        board_state = Array.new(7, -1)
        board_state[player_input] = 3

        game_finish.instance_variable_set(:@board, board)
      end

      it 'returns true' do
        result = game_finish.game_over?(player_input, player)
        expect(result).to be true
      end
    end
  end
end
