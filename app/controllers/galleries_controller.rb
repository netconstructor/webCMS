class GalleriesController < ApplicationController
  def index   
    @galleries = Gallery.all
  end
  def show    
    @galleries = Gallery.all
    @gallery = Gallery.find(params[:id])
  end
  def new     
    @gallery = Gallery.new
    render 'form'
  end
  def edit    
    @gallery = Gallery.find(params[:id])
    render 'form'
  end
  def create  
    @gallery = Gallery.new(params[:gallery])
    flash[:notice] = 'Gallery was successfully created.'
    
    if @gallery.save && params[:continue] == nil
      redirect_to galleries_url
    else
      render 'form'
    end
  end
  def update  
    @gallery = Gallery.find(params[:id])
    flash[:notice] = 'Gallery was successfully updated.'
    
    if @gallery.update_attributes(params[:gallery]) && params[:continue] == nil
      redirect_to galleries_url
    else
      render 'form'
    end
  end
  def destroy 
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    redirect_to galleries_url, :notice => 'Gallery was destroyed.'
  end
end
