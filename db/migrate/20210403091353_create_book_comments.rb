class CreateBookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :book_comments do |t|
      t.integer :book_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
