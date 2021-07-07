class Index < BaseView
  def render
    respond(200, html)
  end

  private

  def html
    response_message = '<h1> Books! </h1>'
    response_message << '<ul>'
    @data&.each do |books|
      response_message << "<li> On <b>#{books['date']}</b>, I bought this book: #{books['isbn']} !</li>"
    end
    response_message << '</ul>'
    response_message
  end
end
