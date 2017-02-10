


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

  Book.all.each do |book|
    if  book.isbn != nil && book.id != 51 && book.id != 45 && book.id != 21
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
