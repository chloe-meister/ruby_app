class Index < BaseView
  def render
    respond(200, html)
  end

  private

  def html
    response_message = "<head>
      <style>
        #{css}
      </style>
      </head><h1> My Books! </h1>"
    response_message << "<table><thead><tr><th colspan='7'>Books</th></tr></thead>"
    response_message << '<tr><td>Date bought</td><td>Cover</td><td>ISBN</td><td>Title</td><td>Author</td>
<td>Date published</td><td>Pages</td></tr>'

    @data&.each do |books|
      response_message << "<tr><td>#{books['date']}</td><td><img src='#{books['image']}'alt='#{books['title']}'/></td>
<td>#{books['isbn']}</td><td>#{books['title']}</td><td>#{books['author']}</td><td>#{books['published']}</td>
<td>#{books['pages']}</td></tr>"
    end
    onclick = "window.location.href='/books/new'"
    response_message << "</table><p></p><button onclick=\"#{onclick}\">Click to add a new book</button>"
    response_message
  end

  def css
"    table,
    td {
      border: 1px solid #333;
    }

    thead,
    tfoot {
      background-color: #333;
        color: #fff;
    }"
  end
end
