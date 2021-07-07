class BaseController

  def initialize(method = GET, data = nil, store = nil, params = {})
    @params = params
    @method = method
    @data = data
    @store = store
  end

  def render(view, opts={})
    require_relative "../app/views/#{controller_name}/#{view}"
    view_formatted = view.to_s.split('_').map(&:capitalize).join
    view_class = self.class.const_get(view_formatted)

    view_class.new(@params).render
  end

  private

  def controller_name
    self.class.to_s.downcase.gsub('controller', '')
  end
end
