


get '/price' do

  a = Mechanize.new { |agent|
    agent.user_agent_alias = 'Mac Safari'
  }

  page = a.get('https://www.amazon.com/dp/1781084637')

  p page.css('a.a-button-text').css('span.a-color-secondary')[0].text.strip

end




get '/price/all' do
  a = Mechanize.new { |agent|
    agent.user_agent_alias = 'Mac Safari'
  }
  bad_isbns = ["1605045748", "0812555473", "0743280822", nil]
  Book.all.each do |book|
    unless bad_isbns.include?(book.isbn)
      @price = Price.new
      @price.book_id = book.id
      page = a.get("https://www.amazon.com/dp/#{book.isbn}")
      @price.cost = page.css('a.a-button-text').css('span.a-color-secondary')[0].text.strip
      @price.save
    end
  end

  redirect '/'

end

get '/price/:id' do

  return 404 if !Book.exists?(params[:id])
  @book = Book.find(params[:id])

  a = Mechanize.new { |agent|
    agent.user_agent_alias = 'Mac Safari'
  }

  page = a.get("https://www.amazon.com/dp/#{@book.isbn}")

  @price = Price.new
  @price.book_id = @book.id
  @price.cost = page.css('a.a-button-text').css('span.a-color-secondary')[0].text.strip
  @price.save

  p @price.cost

  # redirect '/'
end
