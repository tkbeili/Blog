class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  # Favourite assocations
  has_many :favourites, dependent: :destroy
  has_many :favourited_questions, through: :favourites, source: :question


VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
# format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}

def full_name
  "#{first_name} #{last_name}"
end

end
