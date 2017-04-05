module SocraCan17
  module Actions
    class CreateANewSession
      def execute(title:, facilitator:, datetime:, place:, description:)
        Session.new(title: title, facilitator: facilitator, datetime: datetime, place: place, description: description)
      end
    end
  end
end
