describe "Create a new Session Action" do
  let(:a_title) {'irrelevant title'}
  let(:a_facilitator) {'irrelevant facilitator'}
  let(:a_datetime) {'irrelevant date'}
  let(:a_place) {'irrelevant place'}
  let(:a_description) {'irrelevant description'}

  before(:each) do
    @session_repository = instance_spy(SocraCan17::Repositories::SessionRepository)
    @domain_event_publisher = instance_spy(SocraCan17::Infrastructure::DomainEventPublisher)

    @action = SocraCan17::Actions::CreateANewSession.new(@session_repository, @domain_event_publisher)
  end

  it 'creates a new session' do
    session = @action.execute({title: a_title, facilitator: a_facilitator, datetime: a_datetime, place: a_place, description: a_description})
    expect(session.title).to eq(a_title)
    expect(session.facilitator).to eq(a_facilitator)
    expect(session.datetime).to eq(a_datetime)
    expect(session.place).to eq(a_place)
    expect(session.description).to eq(a_description)
  end

  it 'publishes a creation event' do
    @action.execute({title: a_title, facilitator: a_facilitator, datetime: a_datetime, place: a_place, description: a_description})

    expect(@domain_event_publisher).to have_received(:publish).with(have_attributes(
      name: 'session.created'
    ))
  end

  it 'saves session' do
    session = @action.execute({title: a_title, facilitator: a_facilitator, datetime: a_datetime, place: a_place, description: a_description})

    expect(@session_repository).to have_received(:put).with(session)
  end
end
