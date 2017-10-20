class CreateDatabase < ActiveRecord::Migration
  def change
    create_table :databases do |t|
      t.integer :ranking
      t.text    :bookname
      t.text    :author
      t.integer :price
      t.integer :published_date
      t.text    :publisher
      t.text    :image
      t.text    :summary
      t.text    :author_data
      t.integer :score
      t.timestamps
    end
  end
end
