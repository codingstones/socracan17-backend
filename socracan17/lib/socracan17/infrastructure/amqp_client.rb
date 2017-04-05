require 'bunny'

module SocraCan17
  module Infrastructure
    class AMQPClient
      def initialize(url)
        @url = url
      end

      def topic_exchange_declare(name)
        channel.topic(name)
      end

      def exchange_delete(name)
        channel.exchange_delete(name)
      end

      def queue_declare(name)
        channel.queue(name)
      end

      def queue_delete(name)
        channel.queue_delete(name)
      end

      def queue_bind(queue_name, exchange_name, routing_key)
        channel.queue_bind(queue_name, exchange_name, routing_key: routing_key )
      end

      def publish(exchange_name, routing_key, payload)
        exchange = channel.find_exchange(exchange_name)
        exchange.publish(payload, routing_key: routing_key)
      end

      def subscribe(queue_name)
        queue = channel.find_queue(queue_name)
        queue.subscribe do |delivery_info, properties, payload|
          yield payload
        end
      end

      private

      def channel
        if @channel.nil?
          @connection = Bunny.new(@url)
          @connection.start
          @channel = @connection.create_channel
        end
        @channel
      end
    end
  end
end
