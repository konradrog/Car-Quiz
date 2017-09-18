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
      Game.create_questions(@game.id)
      redirect_to @game
    end
  end

  def show
    @game = Game.find(params[:id])
    @questions = @game.questions
  end



  private

  def game_params
    params.require(:game).permit(:level)
  end
end
