class CreateBookCopies < ActiveRecord::Migration
  def change
    create_table :book_copies do |t|
      t.integer :collection_id
      t.integer :book_id
      t.text :comment

      t.timestamps
    end
  end
end
