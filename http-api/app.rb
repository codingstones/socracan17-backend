require 'sinatra'
require 'socracan17'


post '/services' do
  args = Hash[params["params"].map { |key, value| [key.to_sym, value] }]

  SocraCan17::Actions::ACTION_DISPATCHER.dispatch(params["method"].to_sym, args)
end
