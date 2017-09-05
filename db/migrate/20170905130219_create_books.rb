class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.text :title
      t.text :description
      t.integer :year_published

      t.timestamps
    end
  end
end
