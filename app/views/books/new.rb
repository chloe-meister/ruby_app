class New < BaseView
  def render
    respond(200, html)
  end

  def html
    "<form action='/add/book' method='post' enctype='application/x-xxx-form-urlencoded'>
<p><label>Date bought <input type='date' name='date'></label></p>
<p><label>ISBN <input type='number' name='step_count'></label></p>
<p><button>Add new entry</button></p>
</form>"
  end
end
