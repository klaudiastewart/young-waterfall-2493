require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it {should have_many :movie_actors}
    it {should have_many(:movies).through(:movie_actors)}
  end

  describe 'class methods' do
    describe '::unique_actors' do
      it 'only returns unique actors' do
        fox = Studio.create!(name: "Fox", location: "Hollywood")
        titanic = fox.movies.create!(title: "Titanic", creation_year: 1996, genre: "Drama")
        dumbndumber = fox.movies.create!(title: "Dumb", creation_year: 2003, genre: "Comedy")
        leonardo = titanic.actors.create!(name: "Leonardo Dicaprio", age: 23, currently_working: true)
        carey = dumbndumber.actors.create!(name: "Jim Carey", age: 43, currently_working: true)

        expect(Actor.unique_actors).to eq([leonardo.name, carey.name])
      end
    end
  end
end
