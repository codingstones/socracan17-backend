module SocraCan17
  module Actions
    class CreateANewSession
      def initialize(domain_event_publisher)
        @domain_event_publisher = domain_event_publisher
      end

      def execute(title:, facilitator:, datetime:, place:, description:)
        session = Session.new(title: title, facilitator: facilitator, datetime: datetime, place: place, description: description)

        event_data = {
          :title => title,
          :facilitator => facilitator,
          :datetime => datetime,
          :place => place,
          :description => description
        }

        @domain_event_publisher.publish(Infrastructure::DomainEvent.new('session.created', Time.now.utc, event_data))
        session
      end
    end
  end
end
