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
  end

  def check_answers
    good = 0
    bad = 0
    wrong_answer = []
    @game = Game.find(params[:id])
    @game.questions.each_with_index do |question, i|

      answer = question.answers.to_a.find { |a| a.id == params[:answers]["#{question.id}"].to_i}
      answer.checked = true
      if answer.correct == true

        good += 1
      else
        bad += 1
        wrong_answer << i + 1
      end

    end
    flash[:notice] = "good answers : #{good},\n\n bad answers #{bad} for questions #{wrong_answer}"
    unless bad == 0
      # redirect_to game_path(@game, params[:answers].permit!)

      render "show"
    else
      flash[:notice] = "Congratulations! You guess all the cars, what's next ?"
      redirect_to games_path
    end
  end


  private



  def game_params
    params.require(:game).permit(:level, :answers)
  end
end
