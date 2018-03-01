module ApplicationHelper
  def short_nice_date(t)
    t ? t.strftime('%m/%d/%Y') : '-'
  end

  def page_navigation(path)
    current_page?(path) ? 'active' : ''
  end

  def controller_navigation(controller)
    controller_name == controller ? 'active' : ''
  end
  
  def time_select_with_15_gap(h_open, h_close)
    hours = []
    t = h_open
    while t <= h_close
      hours.push(t.strftime('%H:%M'))
      t += 10.minutes
    end
    hours
  end
  def time_select_with_15_gap_after_order(h_open, h_close, active_order)
    # start_time = active_order.updated_at + active_order.restaurant.avg_delivery_time.minutes
    # extra_minutes = 10 - start_time.strftime('%M').to_i % 10
    # start_time = (start_time + extra_minutes.minutes)

    # h_close = h_close.change(year:start_time.year, month:start_time.month, day:start_time.day)
    # h_open = h_open.change(year:start_time.year, month:start_time.month, day:start_time.day)

    # if start_time>h_open && start_time<h_close
    #   h_open = start_time
    # elsif start_time>h_close
    #   h_open = h_open+1.day
    #   h_close = h_close+1.day
    # end
    hours = []
    t = h_open
    while t <= h_close
      hours.push(t.strftime('%H:%M'))
      t += 10.minutes
    end
    hours
  end
  def translate_tag(name)
    key = name.underscore.gsub(' ', '_')
    t('tags.' + key)
  end

  def append_min_time
    if active_order.present?
      hours = time_select_with_15_gap(active_order.restaurant.hours_open.utc, active_order.restaurant.hours_close.utc)
      min_time = (Time.now - 4.hours + active_order.restaurant.avg_delivery_time.minutes).strftime("%H:%M")
      hours = hours.map{ |h| h if h > min_time}.compact
      options =  ""
      hours.each do |hour|
        options += "<option value='#{hour}'>#{hour}</option>"
      end
      options
    end
  end

  def append_time
    if active_order.present?
      hours = time_select_with_15_gap(active_order.restaurant.hours_open.utc, active_order.restaurant.hours_close.utc)
      options =  ""
      hours.each do |hour|
        options += "<option value='#{hour}'>#{hour}</option>"
      end
      options
    end
  end
end