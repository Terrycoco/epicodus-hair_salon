require './lib/stylist.rb'
require './lib/client.rb'
require 'sinatra/reloader'
require 'sinatra'
also_reload '../lib/**/*.rb'
require 'pg'

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @stylists = Stylist.all()
  erb(:index)
end

post('/') do
  firstname = params.fetch('firstname')
  lastname = params.fetch('lastname')
  stylist = Stylist.new({:firstname => firstname, :lastname => lastname, :id => nil})
  stylist.save()
  @stylists = Stylist.all()
  erb(:index)
end
