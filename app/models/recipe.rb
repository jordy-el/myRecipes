class Recipe < ApplicationRecord
  validates :name, uniqueness: true
  paginates_per 12
end
