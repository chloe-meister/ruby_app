class ErrorsController < BaseController
  def not_found
    render(:not_found)
  end

  def standard_error
    render(:error)
  end
end
