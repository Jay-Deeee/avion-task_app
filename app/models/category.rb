class Category < ApplicationRecord
  # has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validates :date, presence: true
end
