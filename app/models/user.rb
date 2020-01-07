class User < ApplicationRecord
    validates :username, presence: true
    has_many :tasks, dependent: :destroy
    has_secure_password
    validates :password, presence: true
end
