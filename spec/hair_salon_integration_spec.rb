require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('viewing list of stylists', {:type => :feature}) do
  it('opens with a list of all stylists and allows salon owner to add a new stylist') do
    visit('/')
    fill_in('firstname', :with => 'Edward')
    fill_in('lastname', :with => 'Scissorhands')
    click_button("Add Stylist")
    expect(page).to have_content('Scissorhands, Edward')
  end
end
