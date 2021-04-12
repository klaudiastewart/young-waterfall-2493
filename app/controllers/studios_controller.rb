class StudiosController < ApplicationController
  def show
    @studio = Studio.find(params[:id])
    binding.pry
  end
end
