class Category < ApplicationRecord
  has_many :breeds
  validates :name, presence: true, uniqueness: true
end
