require './lib/stylist.rb'
require './lib/client.rb'
require 'sinatra/reloader'
require 'sinatra'
also_reload '../lib/**/*.rb'
require 'pg'
require('pry')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @stylists = Stylist.all()
  @client_list = Client.all()
  erb(:index)
end

post('/newstylist') do
  firstname = params.fetch('firstname')
  lastname = params.fetch('lastname')
  stylist = Stylist.new({:firstname => firstname, :lastname => lastname, :id => nil})
  stylist.save()
  @stylists = Stylist.all()
  @client_list = Client.all()
  erb(:index)
end

post('/newclient') do
  firstname = params.fetch('c_firstname')
  lastname = params.fetch('c_lastname')
  client = Client.new({:firstname => firstname, :lastname => lastname, :id => nil})
  client.save()
  @stylists = Stylist.all()
  @client_list = Client.all()
  erb(:index)
end

get('/stylist/:id') do
  sid = params.fetch("id").to_i()
  @client_list = Client.all()
  @stylist = Stylist.find(sid)
  erb(:stylist)
end

get('/stylist/:id/add_client/:client_id') do
  sid = params.fetch("id").to_i()
  cid = params.fetch("client_id").to_i()
  stylist = Stylist.find(sid)
  client = Client.find(cid)
  stylist.add_client(client)
  @client_list = Client.all()
  @stylist = stylist
  erb(:stylist)
end

get('/client/:id') do
  cid = params.fetch("id").to_i()
  @client = Client.find(cid)
  erb(:client)
end

post('/client/:id') do
  cid = params.fetch("id").to_i()
  firstname = params.fetch("firstname")
  lastname = params.fetch("lastname")
  client = client.find(cid)
  client.update({:lastname => lastname, :firstname => firstname})
  @client = client
  erb(:client)
end

get('/client/:id/delete') do
  cid = params.fetch("id").to_i()
  client = Client.find(cid)
  client.delete()
  @stylists = Stylist.all()
  @client_list = Client.all()
  erb(:index)
end

get('/stylist/:id/delete') do
  sid = params.fetch("id").to_i()
  stylist = Stylist.find(sid)
  stylist.delete()
  @stylists = Stylist.all()
  @client_list = Client.all()
  erb(:index)
end
