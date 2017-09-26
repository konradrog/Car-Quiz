class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @games = @user.games.limit(10)
  end
end
