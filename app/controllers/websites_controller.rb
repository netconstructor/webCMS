class WebsitesController < ApplicationController
  skip_before_filter :authorize_user, :load_config, :authorize_plugin
  layout false
  
  def index   
    url = "websites/#{session[:client_id].to_s}/index.erb"
    if FileTest.exists?(url)
      render :layout => 'website', :file => url
    else
      render :nothing => true, :layout => false, :status => 404
    end
  end
  def public  
    url = "websites/#{session[:client_id].to_s}/#{params[:path]}.#{params[:format]}"
    if FileTest.exists?(url)
      respond_to do |format|
        format.js  { render :file => url }
        format.css { render :file => url }
        format.any { send_file url, :disposition => 'inline'}
      end
    else
      render :nothing => true, :layout => false, :status => 404
    end
  end
  
  def login   
    if params[:login] != nil
      users = User.find(:all, :conditions => {:username => params[:login][:username], :password => params[:login][:password]})
      user = nil
      puts session[:client_id]
      users.each do |u|
        if u.group.client_id == session[:client_id]
          user = u
        end
      end
      if user != nil
        session[:user_id] = user.id
        redirect_to root_url
      else
        render :layout => false
      end
    else
      render :layout => false
    end
  end
  def logout  
    session[:user_id]   = nil
    session[:client_id] = nil
    session[:admin]     = nil
    redirect_to root_url
  end
end