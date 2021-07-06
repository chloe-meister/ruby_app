class BaseController
  def render(view, opts={})
    require_relative "../app/views/#{controller_name}/#{view}"
    self.class.const_get(view.capitalize).send(:new).send(:render)
  end

  private

  def controller_name
    self.class.to_s.downcase.gsub('controller', '')
  end
end
