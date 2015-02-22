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
    t = current_user.lists.find_by(name: params["name"])
    t.items.pluck(:description).to_json
  end

  post '/list/:name' do
    t = current_user.lists.find_or_create_by(name: params["name"])
    if params["name"]
      t.add_item params["description"]
    end
    t.to_json
  end

  patch '/due/:id' do
    if params[:id]
      t = current_user.items.find_by(id: params["id"])
      d = Date.parse(params[:due_date])
      t.due(d)
    end
  end

  delete '/item/:id' do
    t = current_user.items.find_by(id: params["id"])
    t.complete
  end

  get '/next' do
    t = current_user.items.sample.description
  end

  get '/search' do
    t = current_user.items
    u = current_user.id
    t.match(u, params["description"])
  end
end

Todoweb.run!
