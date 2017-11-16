 class Review < ActiveRecord::Base
      belongs_to :user
      belongs_to :book
      belongs_to :database
    
      validates :user_id, presence: true
      validates :book_id, presence: true
      validates :review, presence: { message: "レビューがありません。記述してください" }
 
 end