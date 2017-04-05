describe 'POST /services' do
  it 'foobar' do
    post '/services'

    expect(last_response).to be_ok
  end
end
