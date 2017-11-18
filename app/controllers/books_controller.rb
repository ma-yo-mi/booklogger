class BooksController < ApplicationController
  def index
    @books = Book.order('id ASC').limit(5)
  end

  def show
    @database = Database.find(params[:id])
  end


def search_result
  keyword = "%#{params[:search]}%"

  # @books = Book.find_by_sql("select * from books where ('bookname', 'author', 'publisher') LIKE ?", "%#{keyword}")
  # @books = Book.find_by_sql( "SELECT `books`.* FROM `books` WHERE ((bookname LIKE('%#{keyword}%')) OR (author LIKE('%#{keyword}%')) OR (publisher LIKE('%#{keyword}%')))")
  # @books = Book.find_by_sql( "SELECT `books`.* FROM `books` WHERE ((bookname LIKE(?) OR (author LIKE(?) OR (publisher LIKE(?)))", "%#{keyword}%","%#{keyword}%","%#{keyword}%")
# final use for search?
sql = "select * from books where bookname LIKE(?) OR author LIKE(?) OR publisher LIKE(?)"
@books = Database.find_by_sql([sql, keyword, keyword, keyword])



  # @books = Book.where("(bookname LIKE(?)) OR (author LIKE(?)) OR (publisher LIKE(?))", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
end


end
