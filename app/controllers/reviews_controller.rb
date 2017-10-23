class ReviewsController < ApplicationController
    before_action :authenticate_user!, only: :new
    
    def new
        @book = Database.find(params[:book_id])
        @review = Review.new
    end
end
