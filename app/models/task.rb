class Task < ApplicationRecord
  belongs_to :category

  enum status: { pending: 'pending', in_progress: 'in_progress', completed: 'completed' }
  enum priority: { low: 'low', medium: 'medium', high: 'high' }
  validates :title, presence: true
end
