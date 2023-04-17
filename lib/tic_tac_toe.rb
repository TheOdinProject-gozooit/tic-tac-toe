module TicTacToe
  class Player
    attr_accessor :name, :symbol, :win, :lose, :draw

    def initialize(name)
      @name = name
      @symbol = nil
      @win = 0
      @lose = 0
      @draw = 0
    end

    # Display player infos to the console
    def display_info
      puts "Name : #{@name}"
      puts "Symbol : #{@symbol}"
      puts "#{@win}W/#{@lose}L/#{@draw}D"
    end
  end

  class Board
    def initialize
      @grid = Array.new(3) { Array.new(3, ' ') }
    end

    # Display the grid to the console
    def display
      @grid.each_with_index do |row, index|
        puts '---------' unless index.zero?
        puts row.join(' | ')
      end
    end

    # add a symbol to the board
    def add_symbol(position, symbol)
      row = position_to_row(position)
      column = position[1].to_i - 1
      raise StandardError, "'#{column + 1}' is not a valid column, you can chose from '1' to '3'." unless (0..2).include?(column)

      raise StandardError, "Position '#{position}' is already used, chose another." unless @grid[row][column] == ' '

      @grid[row][column] = symbol
    end

    # return false if any emplacement is empty, otherwise return true (= board is full)
    def full?
      @grid.each do |row|
        return false if row.any?(' ')
      end
      true
    end

    # return true if any win is found (vertical, horizontal or diagonal), otherwise false
    def win?(symbol)
      win_row?(symbol) || win_column?(symbol) || win_diagonal?(symbol)
    end

    private

    # return a row number (0, 1, 2) corresponding to the input position (a, b or c)
    def position_to_row(position)
      case position[0].downcase
      when 'a'
        0
      when 'b'
        1
      when 'c'
        2
      else
        raise StandardError, 'This is not a valid row, you can chose from "a" to "c".'
      end
    end

    # return true if there is an horizontal win, otherwise return false
    def win_row?(symbol)
      @grid.any? { |row| row.all?(symbol) }
    end

    # return true if there is a vertical win, otherwise return false
    def win_column?(symbol)
      transposed_grid = @grid.transpose
      transposed_grid.any? { |row| row.all?(symbol) }
    end

    # return true if there is a diagonal win, otherwise return false
    def win_diagonal?(symbol)
      diagonal1 = (0..2).collect { |i| @grid[i][i] }
      diagonal2 = (0..2).collect { |i| @grid[i][2 - i] }

      [diagonal1, diagonal2].any? { |diag| diag.all?(symbol) }
    end
  end

  class Game
    def initialize
      initialize_players
      @board = Board.new
      @current_player = [true, false].sample ? @player1 : @player2
    end

    # the main game loop
    def play
      newgame_presentation
      loop do
        break draw if @board.full?

        play_turn
        break win(@current_player) if @board.win?(@current_player.symbol)

        @current_player = @current_player == @player1 ? @player2 : @player1
      end
      replay
    end

    private

    # give possibility to player to chose if they want to play again or not
    def replay
      puts 'Do you want to play again ? (Y/N)'
      response = gets.chomp.upcase until %w[Y N].include?(response)
      if response == 'Y'
        @board = Board.new
        @current_player = [true, false].sample ? @player1 : @player2
        play
      else
        endgame_recap
      end
    end

    # initialize two players and set their symbols
    def initialize_players
      puts 'Enter player 1 name : '
      @player1 = Player.new(gets.chomp)
      until %w[X O].include?(@player1.symbol)
        puts 'Chose your symbol (X/O) : '
        @player1.symbol = gets.chomp.upcase
      end
      puts 'Enter player 2 name : '
      @player2 = Player.new(gets.chomp)
      @player2.symbol = @player1.symbol == 'X' ? 'O' : 'X'
    end

    # current player chose an emplacement, place the symbol on the grid then display the grid
    def play_turn(current_player = @current_player)
      puts "#{current_player.name} it is your turn to play, chose an emplacement (A1 to C3)"
      position = gets.chomp
      loop do
        @board.add_symbol(position, current_player.symbol)
      rescue StandardError => e
        puts e.message
        puts 'Please choose a different position (A1 to C3)'
        position = gets.chomp
      else
        puts
        @board.display
        puts
        break
      end
    end

    # display informations about each player
    def players_details
      puts 'Player 1 :'
      @player1.display_info
      puts
      puts 'Player 2 :'
      @player2.display_info
    end

    # display informations when a new game begins
    def newgame_presentation
      puts 'The Tic Tac Toe game begins !'
      puts
      players_details
      puts
      @board.display
      puts
      puts "First player to play is : #{@current_player.name}"
      puts
    end

    # display informations when the game is over, such as scores and winner
    def endgame_recap
      puts 'End of the game, thank you for playing ! Here is a recap :'
      puts
      players_details
      puts
      if @player1.win > @player2.win
        puts "Gratz #{@player1.name}, you won most of the games."
      elsif @player1.win < @player2.win
        puts "Gratz #{@player2.name}, you won most of the games."
      else
        puts "Wow ! That's a perfect draw, gratz to both."
      end
    end

    # display gz message as well as incrementing win and lose score for both players
    def win(winner = @current_player)
      puts "Congratulation #{winner.name}, you won this game !"
      looser = winner == @player1 ? @player2 : @player1
      looser.lose += 1
      winner.win += 1
    end

    # display draw message and increment draw score for each player
    def draw
      @player1.draw += 1
      @player2.draw += 1
      puts "The board is full, it's a draw !"
    end
  end
end
