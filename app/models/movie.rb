class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def unique_actors_by_age_and_status
    actors.where(currently_working: :true).order(age: :desc).select(:name).uniq
  end

end
