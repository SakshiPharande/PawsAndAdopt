class Category < ApplicationRecord
  include Discard::Model
  has_many :breeds
  has_many :pets

  validates :category_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters" }
end
