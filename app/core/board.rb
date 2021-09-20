module Core
  class Board
    attr_accessor :width, :heigth, :def_cell

    def initialize(def_cell=Core::Cells::VOID)
      @def_cell = def_cell
    end

    def mount_new_board!(width, heigth)
      @heigth = heigth
      @width = width
      @board = Array.new(heigth) { Array.new(width, @def_cell) }
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
        self[x, y] = Core::Cells::HIDE
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
          key = get_cell_key(cell)
          if is_a_cell_types_valid?(key)
            @board[y].insert(x, key)
          else
            @board[y].insert(x, @def_cell)
          end
        end
      end
    end

    def count_mines(x, y)
      # TODO: Refactor this method using blocks
      count = 0
      (-1..1).each do |i|
        (-1..1).each do |j|
          if i.zero? && j.zero? then next end

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
      self[x, y] = count_mines(x, y)
      if self[x, y].zero?
        explore_around_position!(x, y)
      end
    end

    def to_array
      @board.map { |row| row.map(&:to_s) }
    end

    def merge_and_transfor_to_s(other_board)
      def_cell = other_board.def_cell
      @board.each_with_index.map do |row, y|
        row.each_with_index.map do |cell, x|
          if other_board[x, y].eql?(def_cell) || other_board[x, y].eql?(Core::Cells::MINE)
            cell.to_s
          else
            other_board[x, y].to_s
          end
        end
      end
    end

    private
    def get_cell_key(string)
      begin
        Integer(string)
      rescue ArgumentError
        string.to_sym
      end
    end

    def explore_around_position!(x, y)
      cell_for_explore = get_cell_around(x, y)
      loop do
        x, y = cell_for_explore.pop
        if self.cell_is_void?(x, y)
          self[x, y] = count_mines(x, y)
          if self[x, y].zero?
            cell_for_explore += get_cell_around(x, y)
          end
        end
        unless cell_for_explore.any?
          break
        end
      end
    end

    def get_cell_around(x, y)
      # TODO: Refactor this method using blocks
      cell_for_explore = []
      (-1..1).each do |i|
        (-1..1).each do |j|
          if i.zero? && j.zero? then next end

          begin
            self[x + i, y + j]
          rescue Core::Exceptions::InvalidPosition
            next
          else
            cell_for_explore << [x + i, y + j]
          end
        end
      end
      cell_for_explore
    end

    protected
    def is_a_cell_types_valid?(_)
      false
    end
  end


  class UserBoard < Board

    def initialize
      super(Core::Cells::HIDE)
    end

    protected
    def is_a_cell_types_valid?(type)
      [Core::Cells::HIDE, Core::Cells::RED_FLAG, Core::Cells::QUESTION_FLAG, Core::Cells::SHOW].one?(type)
    end
  end

  class InternalBoard < Board
    
    def initialize
      super(Core::Cells::VOID)
    end

    protected
    def is_a_cell_types_valid?(type)
      [Core::Cells::VOID, Core::Cells::MINE, 0, 1, 2, 3, 4, 5, 6, 7, 8].one?(type)
    end
  end

end
