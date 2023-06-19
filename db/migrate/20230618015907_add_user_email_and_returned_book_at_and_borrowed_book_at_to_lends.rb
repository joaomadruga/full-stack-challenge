class AddUserEmailAndReturnedBookAtAndBorrowedBookAtToLends < ActiveRecord::Migration[6.1]
  def change
    add_column :lends, :user_email, :string
    add_column :lends, :returned_book_at, :datetime
    add_column :lends, :borrowed_book_at, :datetime
  end
end
