describe 'POST /services' do
  before(:each) do
    @id = 30
    request = build_json_rpc_request(:create_a_new_session, {
      :title => 'Commands Surfing to Server',
      :facilitator => 'Alberto Gualis & Néstor Salceda',
      :datetime => 'Tomorrow',
      :place => 'Beach',
      :description => 'We will see how commands flow to server'
    }, id: @id)

    post '/services', request
  end

  it 'uses SocraCan17 action dispatcher for dispatching commands on HTTP API' do
    expect(last_response).to be_ok
  end

  context "when returning a value" do
    it 'sets Content-Type: application/json' do
      expect(last_response.headers).to include('Content-Type' => 'application/json')
    end

    it 'returns a valid jsonrpc response' do
      body = JSON.load(last_response.body)

      expect(body).to include('jsonrpc' => '2.0')
      expect(body).to include('result')
      expect(body).to include('id' => @id)
    end
  end
end

def build_json_rpc_request(method, params, id: nil)
  request = { jsonrpc: "2.0", method: method, params: params, id: id || rand(1000) }

  JSON.dump(request)
end
