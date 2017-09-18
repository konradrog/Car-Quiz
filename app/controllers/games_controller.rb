class GamesController < ApplicationController
  def index
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)

    if @game.new_record?
      render "new"
    else
      redirect_to @game
    end
  end

  private

  def game_params
    params.require(:game).permit(:level)
  end
end
