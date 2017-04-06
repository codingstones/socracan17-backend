require 'sinatra'
require 'sinatra/json'

require 'json'

require 'socracan17'

require_relative 'presenters'


post '/services' do
  body = JSON.load(request.body)

  if body.include? "params"
    args = Hash[body["params"].map { |key, value| [key.to_sym, value] }]
  else
    args = []
  end
  result = SocraCan17::Actions.action_dispatcher.dispatch(body["method"].to_sym, args)

  json \
    "jsonrpc" => "2.0",
    "result" => present(result),
    "id" => body["id"]
end

def present(result)
  presenter_name = result.class.name.split('::')[-1]
  presenter = Kernel.const_get(presenter_name)

  presenter.represent(result).serializable_hash
end
