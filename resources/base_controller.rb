class BaseController

  def initialize(method, model, data = nil, params = {})
    @params = params
    @method = method
    @data = data
    @model = model
  end

  def render(view, opts={})
    controller = opts[:controller] || controller_name

    require_relative "../app/views/#{controller}/#{view}"
    view_formatted = view.to_s.split('_').map(&:capitalize).join
    view_class = self.class.const_get(view_formatted)

    view_class.new(@params, @data).render
  end

  private

  def controller_name
    self.class.to_s.downcase.gsub('controller', '')
  end
end
