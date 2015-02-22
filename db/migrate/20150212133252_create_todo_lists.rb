class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      # t.belongs_to :user
    end
  end
end
