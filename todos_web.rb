require 'sinatra'
require 'pry'
require "./db/setup"
require "./lib/all"

class Todoweb < Sinatra::Base
  # set :bind, '0.0.0.0'
  set :port, '4567' 

  get '/' do
    "testing"
    end

end

Todoweb.run!

# GET   /list   - list all lists 
# GET   /items  - list all items(tasks)
# POST  /list   - create (add) a new list

# GET   /
#       /gifs/random    {random with a tag

# PATCH   /items/27?item=description

# DELETE  /gifs ? id=5    {can only delete “my” gifs
#         /gifs/5