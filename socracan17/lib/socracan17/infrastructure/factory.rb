module SocraCan17
  module Infrastructure
    class Factory
      def domain_event_publisher
        @domain_event_publisher ||= DomainEventPublisher.new(amqp_client, json_serializer)
      end

      def amqp_client
        @amqp_client ||= AMQPClient.new('amqp://localhost:5672')
      end

      def json_serializer
        @json_serializer ||= JSONSerializer.new
      end
    end
  end
end
