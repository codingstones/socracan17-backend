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
        raise ActionNotFoundError unless @actions.include? action
        if args.empty?
          @actions[action].execute
        else
          @actions[action].execute(args)
        end
      end
    end

    class ActionNotFoundError < StandardError
    end
  end
end
