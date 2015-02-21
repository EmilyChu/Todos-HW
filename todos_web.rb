require 'sinatra/base'
require 'pry'
require "./db/setup"
require "./lib/all"

class Todoweb < Sinatra::Base

  get '/list/:name' do
    list_with_tasks =[]
    x = List.find_by(name: params["name"])
    y = Item.where(list_id: x.id)
    z = y.pluck(:description)
      unless y == []
        list_with_tasks<< z
      end
    return list_with_tasks.to_json    
  end

  post '/list/:name' do
    List.find_or_create_by(name: params["name"]).items.create!(description: params["description"])
    "ACCEPTED"
  end

  patch '/due/:id' do
    if params[:id]
      d = Date.parse(params[:due_date])
      t= Item.find_by(id: params["id"])
      t.update!(due_date: d)
    end
  end

  delete '/item/:id' do
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
