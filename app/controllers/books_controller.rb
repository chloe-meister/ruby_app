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

      render(:test)
    end
  end
end
