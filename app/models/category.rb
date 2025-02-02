class Category < ApplicationRecord
  include Discard::Model
  has_many :breeds
  validates :category_name, presence: true
end
