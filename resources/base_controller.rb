class BaseController
  def render(view_filename)
    require_relative "../app/views/#{view_filename}"
    view = view_filename.capitalize.gsub('_', '')
    # TODO verify that the name exists?
    view.send('render')
  end
end
