class List < ActiveRecord::Base
  belongs_to :users
  has_many :items

  def add_list list_name
    l = List.find_or_create_by(name: list_name)
    self.lists<< l
  end
end