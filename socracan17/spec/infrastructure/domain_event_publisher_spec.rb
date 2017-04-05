describe "Domain Event Publisher" do
  let(:an_event_name) { 'session.created' }
  let(:happened_on) { Time.now.utc }

  before(:each) do
    @amqp_client = instance_spy(SocraCan17::Infrastructure::AMQPClient)
    @json_serializer = instance_spy(SocraCan17::Infrastructure::JSONSerializer)
    @event_publisher = SocraCan17::Infrastructure::DomainEventPublisher.new(@amqp_client,  @json_serializer)
  end

  context 'when publishing a domain event' do
    let(:event) { SocraCan17::Infrastructure::DomainEvent.new(an_event_name, happened_on, {}) }

    it 'declares domain-events exchange' do
      @event_publisher.publish(event)

      expect(@amqp_client).to have_received(:topic_exchange_declare).with('domain-events')
    end

    it 'publishes serialized event message' do
      serialized_message = 'irrelevant serialized message'
      allow(@json_serializer).to receive(:serialize).with(event.message).and_return(serialized_message)

      @event_publisher.publish(event)

      expect(@amqp_client).to have_received(:publish).with('domain-events', event.name, serialized_message)
    end
  end
end
