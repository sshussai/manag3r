module ApplicationHelper

  def item_badge(item)
    case item.status
    when 'in-progress'
      badge_color = 'info'
    when 'completed'
      badge_color = 'success'
    else
      badge_color = 'secondary'
    end

    raw "<span class='badge badge-#{badge_color} mb-3'>#{item.status}</span>"
  end
end
