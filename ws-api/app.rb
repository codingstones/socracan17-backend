require 'websocket-eventmachine-server'

require 'socracan17'

require 'json'

factory = SocraCan17::Infrastructure::Factory.new
subscriber = factory.domain_event_subscriber

class BroadcastDomainEventProcessor < SocraCan17::Infrastructure::DomainEventProcessor
  def initialize(websocket)
    @websocket = websocket
  end

  def process(event)
    @websocket.send(JSON.dump(event))
  end
end

EM.run do
  WebSocket::EventMachine::Server.start(:host => "0.0.0.0", :port => 9000) do |ws|
    subscriber.subscribe('session.created', 'session.created', BroadcastDomainEventProcessor.new(ws))

    ws.onopen do
      puts "Client connected"
    end

    ws.onmessage do |msg, type|
      puts "Received message: #{msg}"
      ws.send msg, :type => type
    end

    ws.onclose do
      puts "Client disconnected"
    end
  end
end
