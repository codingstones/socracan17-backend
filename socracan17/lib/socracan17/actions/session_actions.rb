module SocraCan17
  module Actions
    class CreateANewSession
      def initialize(session_repository, domain_event_publisher)
        @session_repository = session_repository
        @domain_event_publisher = domain_event_publisher
      end

      def execute(title:, facilitator:, datetime:, place:, description:)
        session = Session.new(title: title, facilitator: facilitator, datetime: datetime, place: place, description: description)

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
    end
  end
end
