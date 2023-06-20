class Book < ApplicationRecord
  has_many :lends
  validates :title, uniqueness: true
end
