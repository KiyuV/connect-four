# frozen_string_literal: true

class ConnectFour
  def initialize
    @board = Array.new(7) { Array.new(6, ' ') }
    # keeps track of the last piece placed given the column
    @board_state = Array.new(7, -1)
    @tiles_used = 0
  end

  def play
    puts intro
    player = 1
    player_input = ''

    loop do
      print "You're up, "
      if player == 1
        puts 'Player 1!'
        player = 2
      else
        puts 'Player 2!'
        player = 1
      end

      loop do
        player_input = gets.chomp.to_i
        break if valid_move?(player_input)

        puts 'Please enter a valid move:'
      end
      update_board(player_input, player)
      print_board

      if game_over?(player_input, player)
        puts
        if player == 2
          puts 'Congratulations Player 1! You win!'
        else
          puts 'Congratulations Player 2! You win!'
        end
        break
      end

      puts

      if board_full?
        puts 'Draw!'
        break
      end
    end
  end

  def valid_move?(column)
    # While the selected column is not full return true
    if column >= 0 && column <= 6 && @board_state[column] < 5
      true
    else
      false
    end
  end

  def update_board(column, player)
    symbol = player == 1 ? 'O' : 'X'
    row = @board_state[column] += 1
    @board[column][row] = symbol
    @tiles_used += 1
  end

  def board_full?
    @tiles_used >= 42
  end

  def game_over?(player_input, player)
    symbol = player == 1 ? 'O' * 4 : 'X' * 4

    # y co-ordinate of the board
    current_row = @board_state[player_input]

    vertical = @board[player_input].join('')

    horizontal = @board.map { |column| column[current_row] }.join('')

    diagonal1 = [] # /
    -3.upto(3) do |n|
      unless @board[player_input + n][current_row + n].nil? # checks if the current tile qualifies as a diagonal
        diagonal1 << @board[player_input + n][current_row + n]
      end
    rescue NoMethodError
      next
    end

    diagonal2 = [] # \
    -3.upto(3) do |n|
      unless @board[player_input - n][current_row + n].nil? # checks if the current tile qualifies as a diagonal
        diagonal2 << @board[player_input - n][current_row + n]
      end
    rescue NoMethodError
      next
    end

    lines = [vertical, horizontal, diagonal1.join(''), diagonal2.join('')] # Array containing all the possible paths to win
    lines.map { |line| return true if line.include?(symbol) }
    false
  end

  private

  def print_board
    puts '0 1 2 3 4 5 6'
    5.downto(0) do |i|
      puts "#{@board[0][i]} #{@board[1][i]} #{@board[2][i]} #{@board[3][i]} #{@board[4][i]} #{@board[5][i]} #{@board[6][i]}"
    end
    # return nil instead of the return value of #downto
    nil
  end

  def intro
    puts 'Welcome to Connect 4!'
    puts
    print_board
  end
end
