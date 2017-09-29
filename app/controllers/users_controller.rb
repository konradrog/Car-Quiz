class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    
    if params[:order] == "older_first" || nil
      @games = @user.games.order(created_at: :asc).paginate(page: params[:page], per_page: 10)
    elsif params[:order] == "lower_level_first"
      @games = @user.games.order(level: :asc).paginate(page: params[:page], per_page: 10)
    elsif params[:order] == "higher_level_first"
      @games = @user.games.order(level: :desc).paginate(page: params[:page], per_page: 10)
    elsif params[:order] == "finished_first"
      @games = @user.games.order(finished: :desc).paginate(page: params[:page], per_page: 10)
    elsif params[:order] == "unfinished_first"
      @games = @user.games.order(finished: :asc).paginate(page: params[:page], per_page: 10)
    else
      @games = @user.games.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end


    finish = @user.games.where(finished: :true).count
    all = @user.games.count
    @finished = ( finish.to_f / all ) * 100
  end
end
