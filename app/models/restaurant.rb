class Restaurant < ApplicationRecord
  validates_presence_of :category_id, :name, :tel_no, :address, :opening_hours, :description
  mount_uploader :image, PhotoUploader

  has_many :comments, dependent: :destroy
  belongs_to :category, optional: true

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  def is_favorite?(user)
    self.favorited_users.include?(user)
  end

end
