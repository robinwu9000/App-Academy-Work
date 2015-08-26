require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      req.cookies.each do |c|
        if c.name == "_rails_lite_app"
          @value = JSON.parse(c.value)
        end
      end
      @value ||= {}
    end

    def [](key)
      @value[key]
    end

    def []=(key, val)
      @value[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      new_cookie = WEBrick::Cookie.new('_rails_lite_app', @value.to_json)
      res.cookies << new_cookie
    end
  end
end
