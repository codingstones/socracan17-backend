describe "Domain Event Subscriber" do
  let(:queue) { 'irrelevant queue' }
  let(:topic) { 'irrelevant topic' }

  before(:each) do
    @amqp_client = instance_spy(SocraCan17::Infrastructure::AMQPClient)
    @json_serializer = instance_spy(SocraCan17::Infrastructure::JSONSerializer)
    @logger = instance_spy(SocraCan17::Infrastructure::Logger)
    @event_subscriber = SocraCan17::Infrastructure::DomainEventSubscriber.new(@amqp_client, @json_serializer, @logger)

    @domain_event_processor = instance_spy(SocraCan17::Infrastructure::DomainEventProcessor)
  end

  context 'when subscribing to an event queue' do
    before(:each) do
      @event_subscriber.subscribe(queue, topic, @domain_event_processor)
    end

    it 'declares amqp queue' do
      expect(@amqp_client).to have_received(:queue_declare).with(queue)
    end

    it 'binds domain-events exchange with amqp queue' do
      expect(@amqp_client).to have_received(:queue_bind).with(queue, 'domain-events', topic)
    end

    it 'subscribes to queue' do
      expect(@amqp_client).to have_received(:subscribe).with(queue)
    end

    context 'and a message arrives' do
      let(:event) do
        {
          :agent_id => 'irrelevant agent id',
          :issue_id => 'irreelvant issue id',
          :institution => 'irrelevant institution'
        }
      end

      let(:serialized_event) { JSON.dump(event) }

      before(:each) do
        allow(@amqp_client).to receive(:subscribe).and_yield(serialized_event)
        allow(@json_serializer).to receive(:deserialize).with(serialized_event).and_return(event)
      end

      it 'logs that a message has arrived' do
        @event_subscriber.subscribe(queue, topic, @domain_event_processor)

        message = ""
        expect(@logger).to have_received(:info) { |args| message = args }
        expect(message).to eq("#{@domain_event_processor.class} processes event from #{queue} with payload: #{serialized_event}")
      end

      it 'deserializes and send message to event processor' do
        @event_subscriber.subscribe(queue, topic, @domain_event_processor)

        expect(@domain_event_processor).to have_received(:process).with(event)
      end
    end
  end
end
