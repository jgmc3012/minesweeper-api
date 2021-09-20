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

    class GameOver < RuntimeError
      def initialize(message = 'Game over')
        super
      end
    end
  end
end
