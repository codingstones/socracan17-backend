describe "Create a new Session Action" do
  it 'creates a new session' do
    a_title = 'irrelevant title'
    a_facilitator = 'irrelevant facilitator'
    a_datetime = 'irrelevant date'
    a_place = 'irrelevant place'
    a_description = 'irrelevant description'

    action = SocraCan17::Actions::CreateANewSession.new

    session = action.execute(a_title, a_facilitator, a_datetime, a_place, a_description)

    expect(session.title).to eq(a_title)
    expect(session.facilitator).to eq(a_facilitator)
    expect(session.datetime).to eq(a_datetime)
    expect(session.place).to eq(a_place)
    expect(session.description).to eq(a_description)
  end
end
