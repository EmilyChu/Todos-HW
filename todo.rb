require "pry"
require "./db/setup"
require "./lib/all"

puts "Running Todos"

def add (name, description) 
  # List.find_or_create_by(name: name).items.create(description: description)
  List.find_or_create_by(name: name)
  List.find_by(name: name).items.create(description: description)
end

def due (n, date)
  Item.find_by(id: n).update(due_date: date)
end

def done (n)
  Item.find_by(id: n).update(done: true)
end

def l_ist  
  x = Item.where(done: false)
  x.each do |item|
  print "#{item.description} \t\t#{item.due_date}\t\t#{item.done}"
end
end

def given_list (name)
  gl = List.find_by(name: name).items
  puts "This is your #{name} List"
    gl.each do |x|
    print "#{x.description}\t\t#{x.due_date}\t\t#{x.done}"
  end
end

def list_all
  x = List.all
  x.each do |x|
    y = Item.where(list_id: x.id)
    unless y == []
      y.each do |z|
      puts "#{x.name}\t#{z.description}"
      end
    end
  end
end

def next
end

def search (string)
end


command = ARGV.shift  # ARGV is an array and .shift takes out the first element in the array
case command
when "add"
  list = ARGV.shift
  item =ARGV.shift
  add(list, item)
when "due"
  n = ARGV.shift
  date = ARGV.shift
  due(n,date)  
when "done"
  n = ARGV.shift
  done(n)
when "list"
  l_ist
when "given_list"
  name = ARGV.shift
  given_list(name)
when "list_all"
  list_all
when "next"

when "search"

end


# if command == "add"
#   elsif command == "due"
#   elsif command == "done"