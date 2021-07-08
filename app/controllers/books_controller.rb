class BooksController < BaseController
  def index
    set_data
    render(:index)
  end

  def create
    if @method == 'GET'
      render(:new)
    else
      @model.save(@data)
      index
    end
  end

  private

  def set_data
    @data = @model.get
  end
end
