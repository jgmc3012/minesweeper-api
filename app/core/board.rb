module Core
  class Board
    attr_accessor :width, :heigth

    def mount_new_board(width, heigth, def_cell=Core::Cells::VOID)
      @width = width
      @heigth = heigth
      @board = Array.new(heigth) { Array.new(width, def_cell) }
    end

    def [](x, y)
      begin
        @board[y][x]
      rescue NoMethodError
        raise Core::Exceptions::InvalidPosition
      end
    end

    def []=(x, y, value)
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

    def toggle_flag(x:, y:, flag:)
      if self[x, y].eql?(flag)
        self[x, y] = Core::Cells::VOID
      else
        self[x, y] = flag
      end
    end

    def mount_board(data_board)
      data_board.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          n = cell.to_i
          if n.zero?
            self[x, y] = cell.to_sym
          else
            self[x, y] = n
          end
        end
      end
    end

  end

  class UserBoard < Board
    def mount_new_board(width, heigth)
      super(width, heigth, Core::Cells::HIDE)
    end
  end

  class InternalBoard < Board
    def mount_new_board(width, heigth)
      super(width, heigth, Core::Cells::VOID)
    end
  end

end
