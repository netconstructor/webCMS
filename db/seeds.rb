client = Client.create({ :name => 'admin', :domain => $domain })
group  = client.groups.create({:title => 'administrators', :admin => true})
user   = group.users.create({:username => 'demo', :password => 'demo'})