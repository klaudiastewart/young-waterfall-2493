require 'rails_helper'

RSpec.describe Studio, type: :feature do
  it 'shows the attributes of the studio' do
    fox = Studio.create!(name: "Fox", location: "Hollywood")

    visit "/studios/#{fox.id}"

    expect(page).to have_content(fox.name)
    expect(page).to have_content(fox.location)
  end
end
