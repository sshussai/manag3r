class Task < ApplicationRecord
  belongs_to :project

  validates :status, inclusion: { in: %w(not-completed in-progress completed) }

  STATUS_OPTIONS = [
    ['Not competed', 'not-completed'],
    ['In progress', 'in-progress'],
    ['Competed', 'completed']
  ]

end
