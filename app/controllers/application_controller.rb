class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize_website
  before_filter :authorize_user
  before_filter :load_config
  before_filter :authorize_plugin
  private
    def authorize_website 
      puts "authorizing website"
      c = Client.find_by_domain(request.domain)
      if c == nil
        render :status => 404
      elsif session[:client_id] == nil || (session[:client_id] != c.id && session[:admin] == nil)
        session[:client_id] = c.id
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

    def load_config       
      url = "websites/#{session[:client_id].to_s}/config.yml"
      if FileTest.exists?(url)
        $settings = YAML.load_file(url)
      else
        render :nothing => true, :layout => false, :status => 404
      end   
    end
    def authorize_plugin  
      i = false
      $config['plugins'].each do |key, value|
        if value.include?(params[:controller])
          puts key
          i=true if $settings['plugins'].include?(key)
        end
      end
      if i == false
        redirect_to root_url
      end
    end
end