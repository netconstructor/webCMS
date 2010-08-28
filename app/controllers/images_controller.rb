class ImagesController < ApplicationController
  def show    
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end
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
  def edit    
    @image = Image.find(params[:id])
    render 'form'
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
  def update  
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(@image, :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end
  def destroy 
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end
end