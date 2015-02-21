require 'sinatra/base'
require 'pry'
require "./db/setup"
require "./lib/all"

class Todoweb < Sinatra::Base
  # set :bind, '0.0.0.0'
  # set :port, '4567' 

  get '/items' do
    items=[]
    x = Item.where(done: false)
     # x.to_json        # triggers join error
    x.each do |item|
      y = item.description
      items<<y
    end
    items.each do |i|
      print i+" "+"\n"  #formatting doesn't work
    end
  end

  get '/lists' do
    x = List.all
    x.to_json
  #   x.each do |x|
  #     y = Item.where(list_id: x.id)
  #     unless y == []
  #     print x.name
  #     print y["description"]
  #   end
  end

# curl -XPOST http://localhost:4567/lists -d"name: "Drinks"
# curl -i -XPOST http://localhost:4567/lists -d"name=SecondTest" -d"description=is my second param working" 
  post '/lists' do
    List.find_or_create_by(name: params["name"]).items.create!(description: params["description"])
    "ACCEPTED"
  end

# curl -i -XPATCH http://localhost:4567/items -d"id=2" -d"due_date=April 1 2015"
# HTTParty.patch("http://localhost:4567/items", body:{id: '10',due_date: 'March 17 2015'})
  patch '/items' do
    Item.find_by(id: params["id"]).update(due_date: params["due_date"])
    "GET TO IT"
  end

  delete '/items' do
    Item.find_by(id: params["id"]).update(done: params["done"])
    "CHECKKKKK"
  end

  get '/next' do
    tasks = Item.all.sample.description
  end

  get '/search' do
    phrase = params["description"]
    tasks = Item.all
    winning_tasks = []
    tasks.each do |t|
      if /#{phrase}/.match(t.description)
        winning_tasks<< t.description
      else
      end
    end 
    winning_tasks 
  end

end

Todoweb.run!
