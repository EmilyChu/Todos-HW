require 'sinatra/base'
require 'pry'
require "./db/setup"
require "./lib/all"

class Todoweb < Sinatra::Base

  def current_user
    # username = params["user"]
    # # username = request.env["HTTP_AUTHORIZATION"]
    # User.find_by_name username
    u=User.first
    return u
  end

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
    t = current_user.lists.create! description: params["description"]
    if params["name"]
      t.add_list params["name"]
    end
    t.to_json
    # List.find_or_create_by(name: params["name"]).items.create!(description: params["description"])
    # "ACCEPTED"
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
