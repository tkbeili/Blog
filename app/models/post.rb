class Post < ActiveRecord::Base
  has_many(:comments, {dependent: :destroy})

  # taggings associations
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # favourite associations
  has_many :favourites, dependent: :nullify
  has_many :favouriting_users, through: :favourites, source: :user

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  def self.search(search)
    if search
      where("title ILIKE? OR body ILIKE?", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def favourited_by?(user)
    favourite_for(user).present?
  end

  def favourite_for(user)
    favourites.find_by_user_id(user.id)
  end

  after_initialize :set_default_vote_counter


  private

  def set_default_vote_counter
    self.vote_counter ||= 0
  end
end
