class Task < ApplicationRecord
  belongs_to :project

  validates :status, inclusion: { in: %w(not-started in-progress completed) }

  STATUS_OPTIONS = [
    ['Not completed', 'not-started'],
    ['In progress', 'in-progress'],
    ['Competed', 'completed']
  ]

end
