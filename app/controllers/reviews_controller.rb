class ReviewsController < ApplicationController
    before_action :authenticate_user!, only: :new
    
    def new
        @book = Database.find(params[:book_id])
        @review = Review.new
    end
    
    def create
        @review = Review.create(create_params)
        if @review.valid?
            review.save!
            redirect_to_book_review_path
        end
    end



    def update
    end


    def destroy
        review = review.find(params[:id])
        if review destroy?
        redirect_to_book_review_path
        end
    end

    private
    def create_params
        params.require(:review).permit(:rate, :review).merge(book_id: params[:book_id])
    end
end
