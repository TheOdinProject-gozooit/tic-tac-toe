module TicTacToe
  class Player
    attr_accessor :name, :symbol

    def initialize(name)
      @name = name
      @symbol = nil
    end
  end

  class Board
    def initialize
      @first_row = [' ', ' ', ' ']
      @second_row = [' ', ' ', ' ']
      @third_row = [' ', ' ', ' ']
    end

    def display
      puts @first_row.join(' | ')
      puts '---------'
      puts @second_row.join(' | ')
      puts '---------'
      puts @third_row.join(' | ')
    end

    # add a symbol to the board
    def add_symbol(position, symbol)
      row = position_to_row(position)
      column = position[1].to_i - 1
      raise StandardError, 'This is not a valid column, you can chose from "1" to "3".' unless (0..2).include?(column)

      raise StandardError, "Position '#{position}' is already used, please chose another." unless row[column] == ' '

      row[column] = symbol
    end

    def full?
      [@first_row, @second_row, @third_row].each do |row|
        return false if row.any?(' ')
      end
      true
    end

    private

    # return a row corresponding to the input position (a, b or c)
    def position_to_row(position)
      case position[0]
      when 'a'
        @first_row
      when 'b'
        @second_row
      when 'c'
        @third_row
      else
        raise StandardError, 'This is not a valid row, you can chose from "a" to "c".'
      end
    end
  end

  class Game
    def initialize
      initialize_players
      @board = Board.new
      @current_player = [true, false].sample ? @player1 : @player2
    end

    def players_details
      puts "Player 1 name : #{@player1.name}"
      puts "Player 1 symbol : #{@player1.symbol}"
      puts
      puts "Player 2 name : #{@player2.name}"
      puts "Player 2 symbol : #{@player2.symbol}"
    end

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

    def play
      newgame_presentation
      until @board.full? # || win?
        play_turn
        @current_player == @player1 ? @player2 : @player1
      end
    end

    def play_turn(current_player = @current_player)
      puts "#{current_player.name} it is your turn to play, chose an emplacement (A1 to C3)"
      position = gets.chomp
      while true
        begin
          add_symbol(position, current_player.symbol)
        rescue StandardError
          puts "#{position} is not a valid emplacement."
          puts "Please choose a different position (A1 to C3)"
          position = gets.chomp
        else
          puts
          @board.display
          puts
        end
      end
    end

    private

    def initialize_players
      puts 'Enter player 1 name : '
      @player1 = Player.new(gets.chomp)
      until %w[X O].include?(@player1.symbol)
        puts 'Chose your symbol (X/O) : '
        @player1.symbol = gets.chomp
      end
      puts 'Enter player 2 name : '
      @player2 = Player.new(gets.chomp)
      @player2.symbol = @player1.symbol == 'X' ? 'O' : 'X'
    end
  end
end