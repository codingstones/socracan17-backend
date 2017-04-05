describe 'POST /services' do
  it 'uses SocraCan17 action dispatcher for dispatching commands on HTTP API' do
    post '/services', method: :create_a_new_session, params: {
      :title => 'Commands Surfing to Server',
      :facilitator => 'Alberto Gualis & Néstor Salceda',
      :datetime => 'Tomorrow',
      :place => 'Beach',
      :description => 'We will see how commands flow to server'
    }

    expect(last_response).to be_ok
  end
end
