class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @games = @user.games.order(id: :desc).paginate(page: params[:page], per_page: 10)
    finish = @user.games.where(finished: :true).count
    not_finish = @user.games.where(finished: :false).count
    if not_finish != 0
      @finished = ( not_finish / finish.to_f ) * 100
    else
      @finished = 100
    end
  end
end
