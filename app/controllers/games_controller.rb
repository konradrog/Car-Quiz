class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    cars = Car.order("Random()").limit(3).to_a
    @car1 = cars[0]
    @car2 = cars[1]
    @car3 = cars[2]
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)

    if @game.new_record?
      flash[:notice] = "Choose level ;)"
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
    not_checked = 0
    wrong_answer = []
    @game = Game.find(params[:id])
    if params[:answers].nil?
      flash[:notice] = "Choose answers for all questions"
      render "show"
    else
      @game.questions.each_with_index do |question, i|

        answer = question.answers.to_a.find { |a| a.id == params[:answers]["#{question.id}"].to_i}
        if !answer.nil?
          answer.checked = true
          if answer.correct == true
            good += 1
          else
            bad += 1
            wrong_answer << i + 1
          end
        else
          not_checked += 1
        end
      end
      flash[:notice] = "good answers : #{good}, bad answers: for questions #{wrong_answer}, not checked: #{not_checked}"
      if bad > 0 || not_checked > 0
        render "show"
      else
        @game.finished = true
        @game.save
        flash[:notice] = "Congratulations! You guess all the cars, what's next ?"
        redirect_to games_path
      end
    end
  end


  private



  def game_params
    params.key?(:game) ? params.require(:game).permit(:level, :answers) : {}
  end
end
