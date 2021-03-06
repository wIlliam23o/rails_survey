class ScoresController < ApplicationController
  def index
    @scores = current_project.scores.order(updated_at: :desc)
  end

  def show
    @score = current_project.scores.find(params[:id])
  end
end
