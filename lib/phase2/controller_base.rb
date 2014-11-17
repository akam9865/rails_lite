module Phase2
  class ControllerBase
    attr_reader :req, :res

    def initialize(req, res)
      @req = req
      @res = res
      @already_built_response = false
    end

    def already_built_response?
      @already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      raise "double render error" if already_built_response?
      
      @res.header["location"] = url
      @res.status = 302
      @already_built_response = true
      
      nil
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, type)
      raise "double render error" if already_built_response?
      
      @res.content_type = type
      @res.body = content
      @already_built_response = true
    end
  end
end
