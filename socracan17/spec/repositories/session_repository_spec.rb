describe SocraCan17::Repositories::SessionRepository do
  before(:each) do
    @repository = SocraCan17::Repositories::SessionRepository.new
  end

  it "store a session" do
    session = SocraCan17::Session.new(title: 'Irrelevant title')

    @repository.put(session)

    expect(@repository.all()).to eq([session])
  end
end
