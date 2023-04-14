module TicTacToe
  class Player
    def initialize(name)
      @name = name
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

    end
  end
end