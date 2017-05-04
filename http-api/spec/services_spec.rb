describe 'POST /services' do
  let(:id) { 30 }
  let(:action_name) { :create_a_new_session }
  let(:params) do
    {
      :title => 'Commands Surfing to Server',
      :facilitator => 'Alberto Gualis & Néstor Salceda',
      :datetime => 'Tomorrow',
      :place => 'Beach',
      :description => 'We will see how commands flow to server'
    }
  end

  before(:each) do
    SocraCan17::Actions::action_dispatcher = instance_spy(ActionDispatcher::Dispatcher)
    allow(SocraCan17::Actions::action_dispatcher).to receive(:execute).with(:create_a_new_session, params).and_return(SocraCan17::Session.new(title: 'irrelevant title'))

    post '/services', build_json_rpc_request(action_name, params)
  end

  it 'uses SocraCan17 action dispatcher for dispatching commands on HTTP API' do
    expect(SocraCan17::Actions::action_dispatcher).to have_received(:execute).with(:create_a_new_session, params)
  end

  context "when returning a value" do
    it 'sets Content-Type: application/json' do
      expect(last_response.headers).to include('Content-Type' => 'application/json')
    end

    it 'returns a valid jsonrpc response' do
      body = JSON.load(last_response.body)

      expect(body).to include('jsonrpc' => '2.0')
      expect(body).to include('result')
      expect(body).to include('id' => id)
    end

    it 'returns ok if everything goes well' do
      expect(last_response).to be_ok
    end
  end
end

def build_json_rpc_request(method, params)
  request = { jsonrpc: "2.0", method: method, params: params, id: id }

  JSON.dump(request)
end
