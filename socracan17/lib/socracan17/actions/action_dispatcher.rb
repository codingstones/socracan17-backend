module SocraCan17
  module Actions
    @@infrastructure_factory = Infrastructure::Factory.new

    def self.action_dispatcher
      @@action_dispatcher ||= Infrastructure::ActionDispatcher.new
    end

    def self.action_dispatcher=(value)
      @@action_dispatcher = value
    end

    def self.initialize
      action_dispatcher.add_action(:create_a_new_session, CreateANewSession.new(nil,@@infrastructure_factory.domain_event_publisher))
    end

    initialize
  end
end
