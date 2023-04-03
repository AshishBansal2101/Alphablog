class User < ApplicationRecord
    before_save {self.email = email.downcase}
    has_many :articles, dependent: :destroy
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum:25 }
      # Will return an array of follows for the given user instance
    has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"
      # Will return an array of users who follow the user instance
    has_many :followers, through: :received_follows, source: :follower
      # returns an array of follows a user gave to someone else
    has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
      # returns an array of other users who the user has followed
    has_many :followings, through: :given_follows, source: :followed_user
    VAID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum:105 }, format: { with: VAID_EMAIL_REGEX }
    has_secure_password
end