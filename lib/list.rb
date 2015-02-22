class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def add_item description
    i = Item.create!(description: description)
    self.items<< i
  end
  
end