class MovieActorsController < ApplicationController
  def create
    actor = Actor.where(name: params[:actor_name])[0]
    movie = Movie.find(params[:movie_id])
    MovieActor.create!(actor: actor, movie: movie)
    redirect_to "/movies/#{movie.id}"
  end
end
