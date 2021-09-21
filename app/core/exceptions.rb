module Core
  module Exceptions
    class MinesweeperExpection < RuntimeError
    end
    class InvalidPosition < MinesweeperExpection
      def initialize(message = 'Invalid position')
        super
      end
    end

    class MinesExceeded < MinesweeperExpection
      def initialize(message = 'Mines exceeded. Should be 1/3 of the rows*cols.')
        super
      end
    end

    class InvalidDimensions < MinesweeperExpection
      def initialize(message = 'Invalid dimensions. Should be a number between 1 and 25.')
        super
      end
    end
    

    class GameNotStarted < MinesweeperExpection
      def initialize(message = 'Game not started')
        super
      end
    end

    class BoardStarted < MinesweeperExpection
      def initialize(message = 'Board started')
        super
      end
    end

    class GameOver < MinesweeperExpection
      def initialize(message = 'Game over')
        super
      end
    end

    class InvalidCommand < MinesweeperExpection
      def initialize(message = 'Invalid command')
        super
      end
    end

  end
end
