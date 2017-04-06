module SocraCan17
  module Repositories
    class SessionRepository
      def initialize
        @sessions = []
      end

      def put(session)
        @sessions << session
      end

      def all
        @sessions
      end
    end
  end
end
