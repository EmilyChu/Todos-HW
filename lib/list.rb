class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def add_list list_name
    l = List.find_or_create_by(name: list_name)
    self.lists<< l
  end
end