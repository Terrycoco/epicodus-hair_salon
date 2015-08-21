require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('hair salon path', {:type => :feature}) do
  it('opens with a list of all stylists and allows salon owner to add a new stylist') do
    visit('/')
    fill_in('firstname', :with => 'Edward')
    fill_in('lastname', :with => 'Scissorhands')
    click_button("Add New Stylist")
    expect(page).to have_content('Scissorhands, Edward')
  end

  it('allows salon owner to view details of a stylist including client list') do
    s = Stylist.new({:lastname =>'Scissorhands', :firstname => 'Edward', :id => nil})
    s.save()
    sid = s.id()
    c = Client.new({:firstname => 'Terry', :lastname => 'Marr', :id => sid})
    c.save()
    c = Client.new({:firstname => 'Abigail', :lastname => 'Beaty', :id => sid})
    c.save()
    c = Client.new({:firstname => 'Serena', :lastname => 'Smith', :id => sid})
    c.save()
    c = Client.new({:firstname => 'Dimitri', :lastname => 'Doe', :id => nil})
    c.save()
    c = Client.new({:firstname => 'Tony', :lastname => 'Danza', :id => nil})
    c.save()
    visit('/')
    click_link("Scissorhands, Edward")
    expect(page).to have_content('Marr, Terry')
  end
end
