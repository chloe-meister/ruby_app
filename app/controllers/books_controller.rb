class BooksController < BaseController
  def index
    set_data
    render(:index)
  end

  def create
    if @method == 'GET'
      render(:new)
    else
      symb_data = @data.transform_keys(&:to_sym)
      book_data = @model.find_book_info(symb_data)
      @model.save(book_data) if book_data
      index
    end
  rescue StandardError => e
    @data = e.message
    render(:error, {controller: 'errors'})
  end

  private

  def set_data
    @data = @model.get
  end
end
