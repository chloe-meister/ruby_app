require_relative '../../resources/base_controller'

class ErrorsController < BaseController
  def not_found
    render(:not_found)
  end
end
