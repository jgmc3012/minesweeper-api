module Core
  module Exceptions
    class InvalidPosition < RuntimeError
      def initialize(message = 'Invalid position')
        super
      end
    end

    class MinesExceeded < RuntimeError
      def initialize(message = 'Mines exceeded')
        super
      end
    end

    class GameNotStarted < RuntimeError
      def initialize(message = 'Game not started')
        super
      end
    end

    class BoardStarted < RuntimeError
      def initialize(message = 'Board started')
        super
      end
    end

    class GameOver < RuntimeError
      def initialize(message = 'Game over')
        super
      end
    end

    class InvalidCommand < RuntimeError
      def initialize(message = 'Invalid command')
        super
      end
    end

  end
end
