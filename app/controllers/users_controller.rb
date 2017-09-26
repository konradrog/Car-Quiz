class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @games = @user.games.order(id: :desc).paginate(page: params[:page], per_page: 10)
    finish = @user.games.where(finished: :true).count
    all = @user.games.count
    @finished = ( finish.to_f / all ) * 100
  end
end
