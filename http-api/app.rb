require 'sinatra'
require 'sinatra/json'

require 'json'

require 'socracan17'


post '/services' do
  body = JSON.load(request.body)

  args = Hash[body["params"].map { |key, value| [key.to_sym, value] }]

  SocraCan17::Actions.action_dispatcher.dispatch(body["method"].to_sym, args)

  json \
    "jsonrpc" => "2.0",
    "result" => {},
    "id" => body["id"]
end
