class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user

  def existing_tasks
    tasks.select { |task| task.persisted? }
  end

  def status
    if tasks.all? { |task| task.complete? }
      current_status = 'completed'
    elsif tasks.all? { |task| task.in_progress? }
      current_status = 'in-progress'
    else
      current_status = 'not-started'
    end

    current_status
  end

end
