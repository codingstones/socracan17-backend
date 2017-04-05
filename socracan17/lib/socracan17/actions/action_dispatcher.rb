module SocraCan17
  module Actions
    ACTION_DISPATCHER = Infrastructure::ActionDispatcher.new

    ACTION_DISPATCHER.add_action(:create_a_new_session, CreateANewSession.new)
  end
end
