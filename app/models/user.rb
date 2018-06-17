class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  
  has_many :comments, dependent: :destroy#原本的指令，比較想用砍掉了使用者，依然會留著留言
  has_many :restaurants, through: :comments
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

##follow
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

##friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def all_friends
    (friends + inverse_friends).uniq
  end

  def friend?(user)
    self.friends.include?(user) || self.inverse_friends.include?(user)
    #all_friends.include?(user)
  end

  def self.get_user_count
    User.all.size
  end

  def get_comment_count
    self.comments.all.size
  end
end
