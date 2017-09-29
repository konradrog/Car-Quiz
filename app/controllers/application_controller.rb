class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  # def authenticate_user!
  #   if user_signed_in?
  #     super
  #   end
  #   redirect_to games_path, :notice => 'You need to log in or sign up'
  # end
end
