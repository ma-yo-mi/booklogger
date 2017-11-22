class ReviewsController < ApplicationController
    before_action :authenticate_user!, only: :new
    
    def new
        @user = current_user
        @book = Database.find(params[:database_id])
        @review = Review.new
    end
    
    def create
        binding.pry
        @review = Review.create(create_params)
        # if @review.valid?
            @review.save
            redirect_to_database_review_path(database_id)
            flash[:notice] = "レビューは保存されました"
        # end
    end



    def update
        @review = Review.find(params[:id])
        @review.create_params
        redirect_to database_review_path
        flash[:notice] = "レビューを投稿しました"
    end


    def destroy
        @review = review.find(params[:review_id])
        @review.destroy
        if review destroy?
            redirect_to_book_review_path(book_id)
            flash[:notice] ="レビューは削除されました"
        end
    end

    private
    def create_params
        params.require(:review).merge(database_id: params[:database_id])
    end
end
