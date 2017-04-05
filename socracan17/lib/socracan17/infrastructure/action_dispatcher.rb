module SocraCan17
  module Infrastructure
    class ActionDispatcher
      def initialize
        @actions =  {}
      end

      def add_action(name, action)
        @actions[name] = action
      end

      def dispatch(action, args)
        @actions[action].execute(args)
      end
    end
  end
end
