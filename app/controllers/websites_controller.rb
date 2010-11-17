class WebsitesController < ApplicationController
  skip_before_filter :authorize_user, :authorize_plugin
  layout false
  
  def index   
    if session[:user_id] != nil
      @user = User.find(session[:user_id])
      if @user.group.admin == true
        @pages = Page.find(:all, :conditions => {:client_id => session[:client_id], :parent_id => nil})
      else
        @pages = Page.all(:include => :groups, :conditions => ["(#{Group.table_name}.id IS NULL OR #{Group.table_name}.id='#{@user.group_id}') AND #{Page.table_name}.client_id='#{session[:client_id]}' AND #{Page.table_name}.parent_id IS NULL"])
      end
    else
      @pages = Page.all(:include => :groups, :conditions => ["#{Group.table_name}.id IS NULL AND #{Page.table_name}.client_id='#{session[:client_id]}' AND #{Page.table_name}.parent_id IS NULL"])
    end
    if params[:id] == nil
      @page = @pages.first
    else
      @page = Page.find(params[:id]) if Page.exists?(params[:id])
      if @page == nil || @page.client_id != session[:client_id]
        return redirect_to root_url
      end
    end
    
    #define path
    @path = Array.new
    @path << @page.id
    page = @page
    until page.parent_id == nil
      page = Page.find(page.parent_id)
      @path << page.id
    end    
    #check if that page is authorized
    p = Page.find(@path.last)
    if p.groups.count != 0 && (@user == nil || (@user.group.admin == false && !p.groups.exists?(@user.group_id)))
      return redirect_to root_url
    end
    
    #Reverse that shit!
    @path = @path.reverse
    
    url = "websites/#{session[:client_id].to_s}/index.erb"
    if FileTest.exists?(url)
      render :layout => 'website', :file => url
    else
      render :nothing => true, :layout => false, :status => 404
    end
  end
  def public  
    url = "websites/#{session[:client_id].to_s}/public/#{params[:path]}.#{params[:format]}"
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
      users.each do |u|
        if u.group.client_id == session[:client_id]
          user = u
        end
      end
      if user != nil
        session[:admin] = true if $settings['plugins'].include?('clients')
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