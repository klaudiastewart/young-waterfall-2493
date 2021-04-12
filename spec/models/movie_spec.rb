require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :movie_actors}
    it {should have_many(:actors).through(:movie_actors)}
  end

  describe 'instance methods' do
    describe '#unique_actors_by_age_and_status' do
      it 'only returns unique actors ordered by oldest age and who are currently working' do
        fox = Studio.create!(name: "Fox", location: "Hollywood")
        titanic = fox.movies.create!(title: "Titanic", creation_year: 1996, genre: "Drama")
        dumbndumber = fox.movies.create!(title: "Dumb", creation_year: 2003, genre: "Comedy")
        leonardo = titanic.actors.create!(name: "Leonardo Dicaprio", age: 23, currently_working: true)
        carey = dumbndumber.actors.create!(name: "Jim Carey", age: 43, currently_working: true)
        prince = dumbndumber.actors.create!(name: "Prince", age: 60, currently_working: false)

        expect(titanic.unique_actors_by_age_and_status[0].name).to eq(leonardo.name)
        expect(dumbndumber.unique_actors_by_age_and_status[0].name).to eq(carey.name)
        # expect(dumbndumber.unique_actors_by_age_and_status[1].name).to_not eq(prince.name)
      end
    end
  end
end
