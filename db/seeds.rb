puts "#-- creating client"
client = Client.create({ :name => 'admin', :domain => 'localhost', :active => true })
puts "#-- creating part"
part   = client.parts.create({:name => 'body'})
puts "#-- creating administrator group"
group  = client.groups.create({:title => 'administrators', :admin => true})
puts "#-- creating user 'demo', 'demo' and is administrator"
user   = group.users.create({:username => 'demo', :password => 'demo'})
puts "#-- creating page 'hello world'"
page   = client.pages.create({:title => 'hello world'})
puts "#-- Everything is set!"
