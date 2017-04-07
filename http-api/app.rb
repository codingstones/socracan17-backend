require 'sinatra'
require 'sinatra/json'
require 'rack/cors'

require 'socracan17'

require_relative 'jsonrpc'
require_relative 'presenters'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end

post '/services' do
  jsonrpc_request = parse_jsonrpc_request(request)

  result = SocraCan17::Actions.action_dispatcher.dispatch(jsonrpc_request.method, jsonrpc_request.params)

  json jsonrpc_response(present(result), jsonrpc_request.id)
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
