require 'rails_helper'

RSpec.describe Movie, type: :feature do
  it 'shows the attributes of the movie' do
    fox = Studio.create!(name: "Fox", location: "Hollywood")
    titanic = fox.movies.create!(title: "Titanic", creation_year: 1996, genre: "Drama")

    visit "/movies/#{titanic.id}"

    expect(page).to have_content(titanic.title)
    expect(page).to have_content(titanic.creation_year)
    expect(page).to have_content(titanic.genre)
  end

  it 'shows all actors in the movie' do
    fox = Studio.create!(name: "Fox", location: "Hollywood")
    titanic = fox.movies.create!(title: "Titanic", creation_year: 1996, genre: "Drama")
    leonardo = titanic.actors.create!(name: "Leonardo Dicaprio", age: 23, currently_working: true)
    kate = titanic.actors.create!(name: "Kate Winslet", age: 21, currently_working: true)

    visit "/movies/#{titanic.id}"

    expect(page).to have_content(leonardo.name)
    expect(page).to have_content(kate.name)
  end 
end
