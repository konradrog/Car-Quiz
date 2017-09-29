class User < ApplicationRecord
  has_many :games
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.best_scores
    User.joins(:games).group("users.id").sum(:score).sort
  end

  def self.best_players
    best_users = User.best_scores
    users = []
    best_users.each do |k|
      users << User.find(k[0].to_i)
    end
    users
  end
end
