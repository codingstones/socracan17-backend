require 'dry-validation'

module SocraCan17
  module Actions
    class CreateANewSession < ActionWithValidation
      def initialize(session_repository, domain_event_publisher)
        @session_repository = session_repository
        @domain_event_publisher = domain_event_publisher
      end

      def validate(params)
        CreateANewSessionSchema.call(params)
      end

      def do_execute(params)
        session = Session.new(params)

        @session_repository.put(session)
        build_and_publish_created_event(session)

        session
      end

      private

      def build_and_publish_created_event(session)
        event_data = {
          :title => session.title,
          :facilitator => session.facilitator,
          :datetime => session.datetime,
          :place => session.place,
          :description => session.description
        }

        @domain_event_publisher.publish(Infrastructure::DomainEvent.new('session.created', Time.now.utc, event_data))
      end

      CreateANewSessionSchema = Dry::Validation.Schema do
        required(:title).filled
        required(:facilitator).filled
        required(:datetime).filled
        required(:place).filled
        required(:description).filled
      end
    end

    class RetrieveAllSessions
      def initialize(session_repository)
        @session_repository = session_repository
      end

      def execute
        @session_repository.all
      end
    end
  end
end
