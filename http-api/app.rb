require 'oj'
require 'sinatra'
require 'sinatra/json'
require 'rack/cors'

require 'socracan17'

require 'jsonrpc'
require_relative 'presenters'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end

handler = JsonRPC::Handler.new(JsonRPC::Parser.new)

post '/services' do
  response = handler.handle(request.body) do |jsonrpc_request|
    begin
      result = SocraCan17::Actions.action_dispatcher.execute(jsonrpc_request.method.to_sym, jsonrpc_request.params)
      present(result)
    rescue ArgumentError
      raise JsonRPC::InvalidParamsError
    rescue ActionDispatcher::ActionNotFoundError
      raise JsonRPC::MethodNotFoundError
    end
  end
  json response
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
