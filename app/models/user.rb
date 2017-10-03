class User < ApplicationRecord
  has_many :games
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.best_scores
    User.joins(:games).where.not(admin: true).group("users.id").sum(:score).to_a
  end

  def self.best_players
    best_users = User.best_scores.sort { |a, b| b[1] <=> a[1] }
    users = []
    best_users.each do |k|
      users << User.find(k[0])
    end
    users
  end
end
