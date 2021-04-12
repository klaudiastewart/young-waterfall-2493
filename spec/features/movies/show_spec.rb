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

  it 'does not see any actor listed that is not in the movie' do
    fox = Studio.create!(name: "Fox", location: "Hollywood")
    titanic = fox.movies.create!(title: "Titanic", creation_year: 1996, genre: "Drama")
    dumbndumber = fox.movies.create!(title: "Dumb", creation_year: 2003, genre: "Comedy")
    leonardo = titanic.actors.create!(name: "Leonardo Dicaprio", age: 23, currently_working: true)
    kate = titanic.actors.create!(name: "Kate Winslet", age: 21, currently_working: true)
    carey = dumbndumber.actors.create!(name: "Jim Carey", age: 43, currently_working: true)

    visit "/movies/#{titanic.id}"

    expect(page).to have_content(leonardo.name)
    expect(page).to have_content(kate.name)
    expect(page).to_not have_content(carey.name)
  end

  it 'has a form to add an actor to this movie' do
    fox = Studio.create!(name: "Fox", location: "Hollywood")
    titanic = fox.movies.create!(title: "Titanic", creation_year: 1996, genre: "Drama")
    zane = Actor.create!(name: "Brian Zane", age: 28, currently_working: true)

    visit "/movies/#{titanic.id}"
    expect(page).to_not have_content(zane.name)

    fill_in :actor_name, with: zane.name
    click_button "Submit"

    expect(current_path).to eq("/movies/#{titanic.id}")
    expect(page).to have_content(zane.name)
  end
end
