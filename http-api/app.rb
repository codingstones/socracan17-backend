require 'sinatra'
require 'sinatra/json'
require 'rack/cors'

require 'json'

require 'socracan17'

require_relative 'presenters'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end

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
  if result.kind_of? Array
    return [] if result.empty?
    presenter_name = result[0].class.name.split('::')[-1]
  else
    presenter_name = result.class.name.split('::')[-1]
  end

  presenter = Kernel.const_get(presenter_name)

  presenter.represent(result)
end
