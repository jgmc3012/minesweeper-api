module Core
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

    def toggle_flag(x:, y:, flag:)
      if self[x, y].eql?(flag)
        self[x, y] = Core::Cells::VOID
      else
        self[x, y] = flag
      end
    end
  end

  class UserBoard < Board
    def initialize(width, heigth)
      super(width, heigth, Core::Cells::HIDE)
    end
  end

  class InternalBoard < Board
    def initialize(width, heigth)
      super(width, heigth, Core::Cells::VOID)
    end
  end

end
