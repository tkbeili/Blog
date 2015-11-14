class Tag < ActiveRecord::Base
  has_many :taggigs, dependent: :destroy
  has_many :posts, through: :taggings

  validates :name, presence: true, uniqueness: true
end
