


$client = Goodreads::Client.new(
  api_key: ENV['GOODREADS_ACCESS_KEY'],
  api_secret: ENV['GOODREADS_ACCESS_SECRET']
  )

get '/' do
  erb :index
end

get '/update' do
  shelf = $client.shelf(7396358, 'should-read')


  shelf.books.each do |review|
    p review.book.title
    p review.book.id
  end

  redirect '/'
end
