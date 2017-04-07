describe SocraCan17::Infrastructure::ActionDispatcher do
  let(:action_name) { :an_action }
  before(:each) do
    @action = instance_spy(DummyAction)

    @action_dispatcher = SocraCan17::Infrastructure::ActionDispatcher.new
    @action_dispatcher.add_action(action_name, @action)
  end

  it "executes chosen action with keywords parameters" do
    parameters = { :arg1 => 1, :arg2 => 'other argument' }

    @action_dispatcher.dispatch(action_name, parameters)

    expect(@action).to have_received(:execute).with(parameters)
  end

  context "when action does not have any params" do
    it "calls action without any parameters" do
      action = instance_spy(DummyActionWithoutParameters)
      @action_dispatcher.add_action(action_name, action)

      @action_dispatcher.dispatch(action_name, {})

      expect(action).to have_received(:execute)
    end
  end

  context "when action is not found" do
    it "raises an error" do
      non_existent_action_name = :non_existent_action_name
      expect { @action_dispatcher.dispatch(non_existent_action_name, {}) }.to raise_error(SocraCan17::Infrastructure::ActionNotFoundError)
    end
  end
end


class DummyAction
  def execute(arg1:, arg2:)

  end
end

class DummyActionWithoutParameters
  def execute

  end
end
