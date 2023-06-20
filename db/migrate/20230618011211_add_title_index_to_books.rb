class AddTitleIndexToBooks < ActiveRecord::Migration[6.1]
  def change
    add_index :books, :title, name: "index_books_on_title", unique: true, where: "(title IS NOT NULL)"
  end
end
