require 'net/http'
require 'json'

class Books < BaseModel
  def find_book_info(data)
    uri = URI("https://openlibrary.org/api/books?bibkeys=ISBN:#{data[:isbn]}&format=json&jscmd=data")
    res = Net::HTTP.get_response(uri)
    raise new Error('Book not found') unless res.is_a?(Net::HTTPSuccess)

    puts res.body

    res_hash = JSON.parse(res.body)["ISBN:#{data[:isbn]}"]
    book_info = { title: res_hash['title'],
                  pages: res_hash['number_of_pages'],
                  published: res_hash['publish_date'],
                  image: res_hash.dig('cover', 'small'),
                  author: res_hash.dig('authors', 0, 'name') }
    data.merge(book_info)
  end
end
