require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      parse_www_encoded_form(req.query_string) if req.query_string
      parse_www_encoded_form(req.body) if req.body
      route_params.each do |key, value|
        @params[key] = value
      end
    end

    def [](key)
      @params[key.to_s] || @params[key.to_sym]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      decoded = URI::decode_www_form(www_encoded_form)
      result = {}
      decoded.each do |pair|
        parsed = parse_key(pair[0])
        temp = {}
        temp[parsed[-1]] = pair[1]
        parsed.reverse.drop(1).each do |x|
          temp2 = Hash.new
          temp2[x] = temp
          temp = temp2
        end
        if result[parsed[0]]
          result[parsed[0]].merge!(temp[parsed[0]])
        else
          result[parsed[0]] = temp[parsed[0]]
        end
        @params = result
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
