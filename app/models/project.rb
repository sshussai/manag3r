class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user

  def existing_tasks
    tasks.select { |task| task.persisted? }
  end
end
