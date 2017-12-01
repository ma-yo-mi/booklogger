class AddColumnToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :database, index: true, foreign_key: true
  end
end
