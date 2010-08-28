class GalleriesController < ApplicationController
  def index   
    @galleries = Gallery.find_all_by_client_id(session[:client_id])
  end
  def show    
    @galleries = Gallery.find_all_by_client_id(session[:client_id])
    if Gallery.exists?(params[:id])
      @gallery = Gallery.find(params[:id])
      if @gallery.client_id != session[:client_id]
        redirect_to galleries_url, :notice => 'You are not allowed to access that gallery.'
      end
    else
      redirect_to galleries_url, :notice => 'That gallery does not exist.'
    end
  end
  def new     
    @gallery = Gallery.new
    render 'form'
  end
  def edit    
    if Gallery.exists?(params[:id])
      @gallery = Gallery.find(params[:id])
      if @gallery.client_id == session[:client_id]
        render 'form'
      else
        redirect_to galleries_url, :notice => 'You are not allowed to edit that gallery.'
      end
    else
      redirect_to galleries_url, :notice => 'That gallery does not exist.'
    end
  end
  def create  
    @gallery = Gallery.new(params[:gallery])
    @gallery[:client_id] = session[:client_id]
    flash[:notice] = 'Gallery was successfully created.'
    
    if @gallery.save && params[:continue] == nil
      redirect_to @gallery
    else
      render 'form'
    end
  end
  def update  
    if Gallery.exists?(params[:id])
      @gallery = Gallery.find(params[:id])
      if @gallery.client_id == session[:client_id]
        flash[:notice] = 'Gallery was successfully updated.'
        if @gallery.update_attributes(params[:gallery]) && params[:continue] == nil
          redirect_to @gallery
        else
          render 'form'
        end
      else
        redirect_to galleries_url, :notice => 'You are not allowed to update that gallery.'
      end
    else
      redirect_to galleries_url, :notice => 'That gallery does not exist.'
    end
  end
  def destroy 
    if Gallery.exists?(params[:id])
      @gallery = Gallery.find(params[:id])
      if @gallery.client_id == session[:client_id]
        @gallery.destroy
        notice = 'Gallery was destroyed.'
      else
        notice = 'You are not allowed to destroy that gallery.'
      end
    else
      notice = 'That gallery does not exist.'
    end
    redirect_to galleries_url, :notice => notice
  end
end