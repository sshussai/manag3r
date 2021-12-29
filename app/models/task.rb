class Task < ApplicationRecord
  belongs_to :project

  validates :status, inclusion: { in: %w(not-started in-progress completed) }

  STATUS_OPTIONS = [
    ['Not completed', 'not-started'],
    ['In progress', 'in-progress'],
    ['Competed', 'completed']
  ]

  def complete?
    status == 'completed'
  end

  def in_progress?
    status == 'in-progress'
  end

end
