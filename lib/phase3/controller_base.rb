require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    def render(template_name)
      template_code = File.read("views/#{ self.class.name.underscore }/#{ template_name }.html.erb")
      render_content(ERB.new(template_code).result(binding), "text/html")
    end
  end
end
