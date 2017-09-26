class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @games = @user.games.order(id: :desc).limit(10)
  end
end
