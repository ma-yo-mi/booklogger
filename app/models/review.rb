class Review < ActiveRecord::Base
    def create
        review = Review.new
        review.user.id = current_user.id
        if review.valid?
            review.save!
            redirect_to_book_reviews_path
        else
            redirect_to_user_path
        end
    end


def update
end


    def destroy
        review = review.find(params[:id])
        book_id = review/book_id
        review destroy!
        redirect_to_book_review_path
    end
end
