class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  
  has_many :comments dependent: :destroy#原本的指令，比較想用砍掉了使用者，依然會留著留言
  has_many :restaurants, through: :comments
  

  def admin?
    self.role == "admin"
  end
end
