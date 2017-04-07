require 'oj'

JSONRPCRequest = Struct.new(:method, :params, :id)

def parse_jsonrpc_request(request)
  body = Oj.load(request.body)

  if body.include? "params"
    args = Hash[body["params"].map { |key, value| [key.to_sym, value] }]
  else
    args = []
  end

  JSONRPCRequest.new(body["method"].to_sym, args, body["id"])
end

def jsonrpc_response(result, id)
  {
    "jsonrpc" => "2.0",
    "result" => result,
    "id" => id
  }
end
