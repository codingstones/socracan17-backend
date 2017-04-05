module SocraCan17
  module Actions
    def self.action_dispatcher
      @@action_dispatcher ||= Infrastructure::ActionDispatcher.new
    end

    def self.action_dispatcher=(value)
      @@action_dispatcher = value
    end

    def self.initialize
      action_dispatcher.add_action(:create_a_new_session, CreateANewSession.new)
    end

    initialize
  end
end
