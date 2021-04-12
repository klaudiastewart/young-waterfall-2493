require 'rails_helper'

RSpec.describe Studio, type: :feature do
  it 'shows the attributes of the studio' do
    fox = Studio.create!(name: "Fox", location: "Hollywood")

    visit "/studios/#{fox.id}"

    expect(page).to have_content(fox.name)
    expect(page).to have_content(fox.location)
  end

  it 'shows all the titles of all the studios movies' do
    fox = Studio.create!(name: "Fox", location: "Hollywood")
    titanic = fox.movies.create!(title: "Titanic", creation_year: 1996, genre: "Drama")
    dumbndumber = fox.movies.create!(title: "Dumb", creation_year: 2003, genre: "Comedy")

    visit "/studios/#{fox.id}"

    expect(page).to have_content(titanic.title)
    expect(page).to have_content(dumbndumber.title)
  end

  it 'shows a list of actors that have acted in any of the studios movies' do
    fox = Studio.create!(name: "Fox", location: "Hollywood")
    titanic = fox.movies.create!(title: "Titanic", creation_year: 1996, genre: "Drama")
    dumbndumber = fox.movies.create!(title: "Dumb", creation_year: 2003, genre: "Comedy")
    leonardo = titanic.actors.create!(name: "Leonardo Dicaprio", age: 23, currently_working: true)

    visit "/studios/#{fox.id}"

    expect(page).to have_content(leonardo.name)
  end
end
