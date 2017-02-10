


$client = Goodreads::Client.new(
  api_key: ENV['GOODREADS_ACCESS_KEY'],
  api_secret: ENV['GOODREADS_ACCESS_SECRET']
  )

get '/' do
  erb :index
end

get '/update' do
  shelf = $client.shelf(7396358, 'should-read', {per_page: 55})

  shelf.books.each do |review|
    current_book = Book.find_or_initialize_by(goodsreads_id: review.book.id)
    current_book.attributes = {
      isbn: review.book.isbn,
      title: review.book.title,
      ratings_count: review.book.ratings_count,
      small_image_url: review.book.small_image_url,
      image_url: review.book.image_url,
      average_rating: review.book.average_rating,
      author: review.book.authors.author.name,
      description: review.book.description,
    }
    p current_book.title
    current_book.save
  end

  redirect '/'
end
