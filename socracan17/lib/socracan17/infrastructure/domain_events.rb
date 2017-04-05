require 'logger'

module SocraCan17
  module Infrastructure
    class DomainEventPublisher
      def initialize(amqp_client, json_serializer)
        @amqp_client = amqp_client
        @exchange = 'domain-events'
        @json_serializer = json_serializer
      end

      def publish(event)
        @amqp_client.topic_exchange_declare(@exchange)

        @amqp_client.publish(@exchange, event.name, @json_serializer.serialize(event.message))
      end
    end

    class DomainEventSubscriber
      def initialize(amqp_client, json_serializer, logger)
        @amqp_client = amqp_client
        @json_serializer = json_serializer
        @logger = logger
        @exchange = 'domain-events'
      end

      def subscribe(queue, topic, domain_event_processor)
        declare_and_bind_to_queue(queue, topic)

        @amqp_client.subscribe(queue) do |payload|
          @logger.info("#{domain_event_processor.class} processes event from #{queue} with payload: #{payload}")

          domain_event_processor.process(@json_serializer.deserialize(payload))
        end
      end

      private

      def declare_and_bind_to_queue(queue, topic)
        @amqp_client.queue_declare(queue)
        @amqp_client.queue_bind(queue, @exchange, topic)
      end
    end

    class DomainEventProcessor
      def process(domain_event)
        raise NotImplementedError
      end
    end

    class DomainEvent
      attr_reader :name, :happened_on

      def initialize(name, happened_on, data)
        @name = name
        @happened_on = happened_on
        @data = data
      end

      def message
        {
          :name => name,
          :happened_on => happened_on,
          :data => @data
        }
      end
    end
  end
end
