class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :body
      t.boolean :is_completed

      t.timestamps
    end
  end
end
