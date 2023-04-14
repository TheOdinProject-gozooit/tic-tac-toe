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
    end

    # def initialize_players_symbols
    #   symbols = %w[X O]
    #   @player1.symbol = symbols.delete_at(rand(2))
    #   @player2.symbol = symbols.join
    #   puts "#{@player1.name} is playing '#{@player1.symbol}'."
    #   puts "#{@player2.name} is playing '#{@player2.symbol}'."
    # end

    # def switch_players_symbols
    #   tmp = @player1.symbol
    #   @player1.symbol = @player2.symbol
    #   @player2.symbol = tmp
    #   puts "#{@player1.name} is playing '#{@player1.symbol}'."
    #   puts "#{@player2.name} is playing '#{@player2.symbol}'."
    # end

    def play_turn

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