class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
    end
  end
end
