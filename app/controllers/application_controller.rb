class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize_website
  before_filter :authorize_user
  
  private
    def authorize_website 
      puts "authorizing website"
      c = Client.find_by_domain(request.domain)
      if c == nil
        render :status => 404
      elsif session[:client_id] == nil || (session[:client_id] != c.id && session[:admin] == nil)
        session[:client_id] = c.id
      end
      if request.domain == $domain
        session[:admin] = true
      end
      return true
    end
    def authorize_user    
      puts "authorizing user"
      if session[:user_id] != nil && User.exists?(session[:user_id])
        u = User.find(session[:user_id])
        if u.group.admin == false
          redirect_to root_url
        end
      else
        redirect_to '/login'
      end
      return true
    end
end