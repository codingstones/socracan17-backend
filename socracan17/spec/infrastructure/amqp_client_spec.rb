describe SocraCan17::Infrastructure::AMQPClient, :integration do
  subject{ SocraCan17::Infrastructure::AMQPClient.new("amqp://localhost:5672") }

  let(:exchange)  {'sample_exchange' }
  let(:queue) { 'a_queue' }

  before(:each) do
    subject.queue_delete(queue)
    subject.exchange_delete(exchange)
  end

  context 'when publishing using a topic exchange' do
    it 'reads message published' do
      content = 'sample test'
      routing_key = 'a_queue'
      was_read = false

      subject.topic_exchange_declare(exchange)
      subject.queue_declare(queue)
      subject.queue_bind(queue, exchange, routing_key)

      subject.publish(exchange, routing_key, content)

      subject.subscribe(queue) do |payload|
        expect(payload).to eq(content)
        was_read = true
      end

      sleep(0.1)
      expect(was_read).to be_truthy
    end
  end
end
