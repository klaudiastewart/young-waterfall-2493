class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.unique_actors
    select(:name).distinct.pluck(:name)
  end
end
