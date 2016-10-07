module ApplicationHelper
  def body_data_page
    request.path.split('/')[1..(request.path.split('/').length)].join(':')
  rescue
    nil
  end

  def active(_path)
    if request.path.match(_path)
      'active'
    end
  end
end
