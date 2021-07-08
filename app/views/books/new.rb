class New < BaseView
  def render
    respond(200, html)
  end

  def html
    "<form action='/books/new' method='post' enctype='application/x-xxx-form-urlencoded'>
<p><label>Date bought <input type='date' name='date'></label></p>
<p><label>ISBN <input name='isbn'></label></p>
<p><button>Add new entry</button></p>
</form>"
  end
end
