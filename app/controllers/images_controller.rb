class ImagesController < ApplicationController
  def new     
    if Gallery.exists?(params[:gallery_id])
      @gallery = Gallery.find(params[:gallery_id])
      if @gallery.client_id == session[:client_id]
        @gallery = Gallery.find(params[:gallery_id])
        render 'form'
      else
        redirect_to galleries_url, :notice => 'You are not allowed to access that gallery.'
      end
    else
      redirect_to galleries_url, :notice => 'That gallery does not exist.'
    end
  end
  def create  
    status = 500
    @image = Image.new(:data => params[:Filedata])
    if Gallery.exists?(params[:gallery_id])
      gallery = Gallery.find(params[:gallery_id])
      if gallery.client_id == session[:client_id]
        @image[:gallery_id] = gallery.id
        if @image.save
          status = 200
        end
      end
    end
    render :nothing => true, :status => status 
  end
  def destroy 
    id = params[:id].split('_').last
    if Image.exists?(id)
      @image = Image.find(id)
      if @image.gallery.client_id == session[:client_id]
        @image.destroy
      end
    end
    render :nothing => true
  end
  def sort    
    if Gallery.exists?(params[:gallery_id])
      gallery = Gallery.find(params[:gallery_id])
      if gallery.client_id == session[:client_id]
        gallery.images.all.each do |image|
          image.position = params[:image].index(image.id.to_s) + 1
          image.save
        end
      end
    end
    render :nothing => true
  end
  def drop    
    puts gallery_id = params[:gallery_id].split('_').last
    puts image_id = params[:image_id].split('_').last
    if Gallery.exists?(gallery_id) && Image.exists?(image_id)
      gallery = Gallery.find(gallery_id )
      if gallery.client_id == session[:client_id]
        image = Image.find(image_id)
        image.gallery_id = gallery_id
        image.position = 0
        image.save
      end
    end
    render :nothing => true
  end
  def insert  
    render :json => { :error => false, :url => 'assets/photos/5/small.jpg', :width => 300, :height => 300 }
    #render :layout => 'wymiframe'
  end
end