module ProjectsHelper

  def completed_tasks(project)
    raw "(#{project.completed_task_count}/#{project.total_tasks} tasks completed)"
  end
end
