class BooksController < ApplicationController
  def index
    @books = Book.order('id ASC').limit(20)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new

  end

  def create

  end


def search
  @books = []
end

  private

end
