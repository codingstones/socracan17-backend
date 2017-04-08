module SocraCan17
  module Actions
    @@infrastructure_factory = Infrastructure::Factory.new
    @@repository_factory = Repositories::Factory.new

    def self.action_dispatcher
      @@action_dispatcher ||= Infrastructure::ActionDispatcher.new
    end

    def self.action_dispatcher=(value)
      @@action_dispatcher = value
    end

    def self.initialize
      action_dispatcher.add_action(:create_a_new_session,
        CreateANewSession.new(
          @@repository_factory.session_repository,
          @@infrastructure_factory.domain_event_publisher
        )
      )

      action_dispatcher.add_action(:retrieve_all_sessions,
        RetrieveAllSessions.new(@@repository_factory.session_repository)
      )
    end

    initialize
  end
end
