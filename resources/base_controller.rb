class BaseController
  def render(view, opts={})
    require_relative "../app/views/#{controller_name}/#{view}"
    view_formatted = view.to_s.split('_').map(&:capitalize).join

    self.class.const_get(view_formatted).send(:new).send(:render)
  end

  private

  def controller_name
    self.class.to_s.downcase.gsub('controller', '')
  end
end
