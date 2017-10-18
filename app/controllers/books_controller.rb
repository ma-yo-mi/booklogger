class BooksController < ApplicationController
  def index
    @books = Book.order('id ASC').limit(5)
  end

  def show
    @book = Book.find(params[:id])
  end



def search_result
  @books = Book.search(params[:q])
  render "index"
end



end
