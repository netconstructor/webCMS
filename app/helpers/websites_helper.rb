module WebsitesHelper
  def admin?    
    if session[:user_id] != nil
      u = User.find(session[:user_id])
      return u.group.admin
    else
      return false
    end
  end
  def logged_in?
    if session[:user_id] != nil
      return true
    else
      return false
    end
  end
  def render_level(parent_id)   
    return Page.find_all_by_parent_id(parent_id)
  end
  def render_content(item)      
    url = "features/#{item.link_type.downcase.pluralize}/#{item.feature}.erb"
    if FileTest.exists?(url)
      render :file => url, :locals => {:item => item.link}
    end
  end
end