describe "Retrieve all Sessions" do
  let(:a_title) { 'a title' }
  let(:other_title) { 'other title' }

  before(:each) do
    @session_repository = instance_spy(SocraCan17::Repositories::SessionRepository)
    @action = SocraCan17::Actions::RetrieveAllSessions.new(@session_repository)
  end

  it 'retrieves all sessions' do
    sessions = [SocraCan17::Session.new(title: a_title), SocraCan17::Session.new(title: other_title)]
    allow(@session_repository).to receive(:all).and_return(sessions)

    retrieved = @action.execute

    expect(retrieved).to eq(sessions)
  end
end
