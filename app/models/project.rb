class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user

  def existing_tasks
    tasks.select { |task| task.persisted? }
  end

  def status
    return 'not-started' if tasks.none?

    if tasks.all? { |task| task.complete? }
      current_status = 'completed'
    elsif tasks.any? { |task| task.in_progress? || task.complete? }
      current_status = 'in-progress'
    else
      current_status = 'not-started'
    end

    current_status
  end

  def percent_complete
    return 0 if tasks.none?
    ((completed_task_count.to_f / tasks.count) * 100).round
  end

  def total_tasks
    tasks.count
  end

  def completed_task_count
    tasks.select { |task| task.complete? }.count
  end

end
