
get '/book/:id' do
  @book = Book.find(params[:id])
  erb :'book/show'
end
