describe SocraCan17::Repositories::SessionRepository do
  it "store a session" do
    repository = SocraCan17::Repositories::SessionRepository.new
    session = SocraCan17::Session.new(title: 'Irrelevant title')
    repository.put(session)

    retrieved = repository.all()

    expect(retrieved).to eq([session])
  end
end
