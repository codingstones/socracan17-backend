describe "Create a new Session Action" do
  let(:a_title) {'irrelevant title'}
  let(:a_facilitator) {'irrelevant facilitator'}
  let(:a_datetime) {'irrelevant date'}
  let(:a_place) {'irrelevant place'}
  let(:a_description) {'irrelevant description'}

  it 'creates a new session' do
    action = SocraCan17::Actions::CreateANewSession.new

    session = action.execute(a_title, a_facilitator, a_datetime, a_place, a_description)

    expect(session.title).to eq(a_title)
    expect(session.facilitator).to eq(a_facilitator)
    expect(session.datetime).to eq(a_datetime)
    expect(session.place).to eq(a_place)
    expect(session.description).to eq(a_description)
  end
end
