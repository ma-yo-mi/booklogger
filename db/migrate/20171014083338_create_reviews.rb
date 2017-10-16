class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text    :review
      t.integer :score
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
