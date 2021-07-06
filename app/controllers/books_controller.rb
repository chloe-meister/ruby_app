require_relative '../../resources/base_controller'

class BooksController < BaseController
  def index
    render(:index)
  end
end
