class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
    
      t.belongs_to :list
    end

    create_table :lists do |t|
      t.string :name
    
      t.belongs_to :user
    end

    create_table :items do |t|
      t.string :description
      t.datetime :due_date
      t.boolean :done, default: false
      t.timestamp
    
      t.belongs_to :user
      t.belongs_to :list
    end
  end
end
