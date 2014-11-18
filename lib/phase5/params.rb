require 'uri'

module Phase5
  class Params
    def initialize(req, route_params = {})
      @params = {}
      @params.merge!(route_params)
      
      if req.query_string
        @params.merge!(parse_www_encoded_form(req.query_string))
      end
      
      if req.body
        @params.merge!(parse_www_encoded_form(req.body))
      end
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    def parse_www_encoded_form(www_encoded_form)

      
      key_values = URI.decode_www_form(www_encoded_form)
      params = {}
      
      key_values.each do |full_key, value|
        scope = params
        parsed_key = parse_key(full_key)
        
        parsed_key.each_with_index do |key, index|
          if index + 1 == parsed_key.length
            scope[key] = value
          else
            scope[key] ||= {}
            scope = scope[key]
          end
        end
      end
      
      params
    end

    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
