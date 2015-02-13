class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.datetime :due_date
      t.boolean :done  # :done, default: false
      t.timestamp
      t.belongs_to :list
    end
  end
end
