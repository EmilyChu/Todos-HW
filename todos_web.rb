require 'sinatra'
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

end

Todoweb.run!

# GET   /list   - lists all lists 
# GET   /items  - lists all items(tasks)
# POST  /lists   - adds a new list and/or task to existing list

# GET   /
#       /gifs/random    {random with a tag

# PATCH   /items/27?item=description

# DELETE  /gifs ? id=5    {can only delete “my” gifs
#         /gifs/5