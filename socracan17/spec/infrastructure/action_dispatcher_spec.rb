describe SocraCan17::Infrastructure::ActionDispatcher do
  let(:action_name) { :an_action }
  before(:each) do
    @action = instance_spy(DummyAction)

    @action_dispatcher = SocraCan17::Infrastructure::ActionDispatcher.new
    @action_dispatcher.add_action(action_name, @action)
  end

  it "executes chosen action with specified parameters" do
    parameters = { :arg1 => 1, :arg2 => 'other argument' }

    @action_dispatcher.dispatch(action_name, parameters)

    expect(@action).to have_received(:execute).with(*parameters)
  end
end


class DummyAction
  def execute(arg1, arg2)

  end
end
