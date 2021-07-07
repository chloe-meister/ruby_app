class BooksController < BaseController
  def index
    render(:index)
  end

  def show

  end

  def create
    if @method == 'GET'
      render(:new)
    else
      # save the data
    end
  end
end
