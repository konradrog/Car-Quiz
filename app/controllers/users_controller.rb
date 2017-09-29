class UsersController < ApplicationController
  def index
    @users = User.best_players
    @scores = User.best_scores
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
    total_score
    choose_order(params)
    finished_games
  end

  def finished_games
    finish = @user.games.where(finished: :true).count
    @finished = ( finish.to_f / @user.games.count ) * 100
  end

  def total_score
    @total_score = 0
    @games.each do |e|
      @total_score += e.score
    end
  end

  def choose_order(params)
    case params[:order]
    when "older_first" || nil
      @games = @games.order(created_at: :asc)
    when "lower_level_first"
      @games = @games.order(level: :asc)
    when "higher_level_first"
      @games = @games.order(level: :desc)
    when "finished_first"
      @games = @games.order(finished: :desc)
    when "unfinished_first"
      @games = @games.order(finished: :asc)
    else
      @games = @games.order(created_at: :desc)
    end
    @games = @games.paginate(page: params[:page], per_page: 10)
  end
end
