class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         include Discard::Model
         validates :email, presence: true, uniqueness: true
         enum role: { user: 0, admin: 1 }
end
