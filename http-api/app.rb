require 'sinatra'
require 'sinatra/json'

require 'json'

require 'socracan17'

require_relative 'presenters'


post '/services' do
  body = JSON.load(request.body)

  args = Hash[body["params"].map { |key, value| [key.to_sym, value] }]
  result = SocraCan17::Actions.action_dispatcher.dispatch(body["method"].to_sym, args)

  #presenter = result.class.name.split('::')[-1]

  json \
    "jsonrpc" => "2.0",
    "result" => Session.represent(result).serializable_hash,
    "id" => body["id"]
end
