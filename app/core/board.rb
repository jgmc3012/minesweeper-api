module Core
  class Board
    attr_accessor :width, :heigth

    def mount_new_board!(width, heigth, def_cell=Core::Cells::VOID)
      @width = width
      @heigth = heigth
      @board = Array.new(heigth) { Array.new(width, def_cell) }
    end

    def [](x, y)
      if x.negative? || x >= @width || y.negative? || y >= @heigth
        raise Core::Exceptions::InvalidPosition
      end
      @board[y][x]
    end

    def []=(x, y, value)
      if x.negative? || x >= @width || y.negative? || y >= @heigth
        raise Core::Exceptions::InvalidPosition
      end
      @board[y][x] = value
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

    def toggle_flag!(x:, y:, flag:)
      if self[x, y].eql?(flag)
        self[x, y] = Core::Cells::VOID
      else
        self[x, y] = flag
      end
    end

    # Read an array of arrays and return a new board
    def mount_board!(data_board)
      if defined?(@board)
        raise Core::Exceptions::BoardStarted
      else
        @board = []
      end
      @heigth = data_board.length
      @width = data_board[0].length
      data_board.each_with_index do |row, y|
        @board.insert(y, [])
        row.each_with_index do |cell, x|
          n = cell.to_i
          if n.zero?
            @board[y].insert(x, cell.to_sym)
          else
            @board[y].insert(x, n)
          end
        end
      end
    end

    def count_mines(x, y)
      count = 0
      (-1..1).each do |i|
        (-1..1).each do |j|
          begin
            count += 1 if self[x + i, y + j].eql?(Core::Cells::MINE)
          rescue Core::Exceptions::InvalidPosition
            next
          end
        end
      end
      count
    end

    def explore_position!(x, y)
      mines = count_mines(x, y)
      if mines.zero?
        # TODO: Explore all the cells around
      else
        self[x, y] = mines
      end
    end

    def to_array
      @board.map { |row| row.map(&:to_s) }
    end
  end

  class UserBoard < Board
    def mount_new_board!(width, heigth)
      super(width, heigth, Core::Cells::HIDE)
    end
  end

  class InternalBoard < Board
    def mount_new_board!(width, heigth)
      super(width, heigth, Core::Cells::VOID)
    end
  end

end
