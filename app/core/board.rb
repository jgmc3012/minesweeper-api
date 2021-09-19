module Core
  class Board < Struct.new(:width, :heigth)
    def initialize(width, heigth)
      super
      @board = Array.new(width) { Array.new(heigth) }
    end

    def [](width, heigth)
      @board[width][heigth]
    end

    def []=(width, heigth, value)
      @board[width][heigth] = value
    end
  end

  class Game < Struct.new(:user_board, :mines_board, :flags_board)
    def start_game(width, heigth, mines)
      @user_board = Board.new(width, heigth)
      @mines_board = Board.new(width, heigth)
      @flags_board = Board.new(width, heigth)
      mines.times { add_mine }
    end

    private
    def add_mine
      while true
        x = rand(@user_board.width)
        y = rand(@user_board.heigth)
        if @mines_board.null_cell?(x, y)
          @mines_board[x, y] = '*'
          break
        end
      end
    end
  end
end
