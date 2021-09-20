module Core
  module Cells
    RED_FLAG = :R
    QUESTION_FLAG = :Q
    HIDE = :H
    VOID = nil
    MINE = :M
  end

  class Board
    attr_accessor :width, :heigth

    def initialize(width, heigth, def_cell)
      @width = width
      @heigth = heigth
      @board = Array.new(width) { Array.new(heigth, def_cell) }
    end

    def [](width, heigth)
      begin
        @board[width][heigth]
      rescue NoMethodError
        raise Core::Exceptions::InvalidPosition
      end
    end

    def []=(width, heigth, value)
      @board[width][heigth] = value
    end

    def cell_is_void?(x, y)
      self[x, y].eql?(Core::Cells::VOID)
    end

    def one_third
      (@width * @heigth) / 3
    end

    def all?(type)
      @board.all? { |row| row.all? { |cell| cell.eql?(type) } }
    end

    def count(type)
      @board.flatten.count(type)
    end
  end

  class Game
    def flags_board
      begin
        @flags_board
      rescue NoMethodError
        raise Core::Exceptions::GameNotStarted
      end
    end

    def user_board
      begin
        @user_board
      rescue NoMethodError
        raise Core::Exceptions::GameNotStarted
      end
    end

    def mines_board
      begin
        @mines_board
      rescue NoMethodError
        raise Core::Exceptions::GameNotStarted
      end
    end

    def new_game(width:, heigth:, mines:)
      @user_board = Board.new(width, heigth, Core::Cells::HIDE)
      unless mines.between?(1, @user_board.one_third)
        raise Core::Exceptions::MinesExceeded
      end
      @mines_board = Board.new(width, heigth, Core::Cells::VOID)
      @flags_board = Board.new(width, heigth, Core::Cells::VOID)
      mines.times { add_mine }
    end

    private

    def add_mine
      while true
        x = rand(@user_board.width)
        y = rand(@user_board.heigth)
        if @mines_board.cell_is_void?(x, y)
          @mines_board[x, y] = Core::Cells::MINE
          break
        end
      end
    end
  end
end
