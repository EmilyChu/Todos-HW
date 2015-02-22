class Item < ActiveRecord::Base 
  belongs_to :list
  belongs_to :user

  def due due_date
    update(due_date: due_date)
  end

  def complete
    update(done: true)
  end

  def self.match user_id, description   #not sure why i need self.., but i get an undefined method error without it.
    tasks=[]
    items = Item.where(user_id: user_id) 
    items.each do |i|
      if /#{description}/.match(i.description)
        tasks<<i.description
      else
      end
    end
    tasks
  end
end
