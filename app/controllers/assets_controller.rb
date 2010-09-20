class AssetsController < ApplicationController
  def index   
    @folders = Folder.find_all_by_client_id(session[:client_id])
    render :layout => false
  end
  def new     
    if Folder.exists?(params[:folder_id])
      @folder = Folder.find(params[:folder_id])
      if @folder.client_id == session[:client_id]
        @folder = Folder.find(params[:folder_id])
        render 'form'
      else
        redirect_to folders_url, :notice => 'You are not allowed to access that folder.'
      end
    else
      redirect_to folders_url, :notice => 'That folder does not exist.'
    end
  end
  def create  
    @asset = Asset.new
    status = 500
    @asset = Asset.new(:data => params[:Filedata])
    if Folder.exists?(params[:folder_id])
      folder = Folder.find(params[:folder_id])
      if folder.client_id == session[:client_id]
        @asset[:folder_id] = folder.id
        if @asset.save
          status = 200
        end
      end
    end
    render :nothing => true, :status => status 
  end
  def destroy 
    id = params[:id].split('_').last
    if Asset.exists?(id)
      @asset = Asset.find(id)
      if @asset.folder.client_id == session[:client_id]
        @asset.destroy
      end
    end
    render :nothing => true  
  end
  def sort    
    if Folder.exists?(params[:folder_id])
      folder = Folder.find(params[:folder_id])
      if folder.client_id == session[:client_id]
        folder.assets.all.each do |asset|
          asset.position = params[:asset].index(asset.id.to_s) + 1
          asset.save
        end
      end
    end
    render :nothing => true
  end
  def drop    
    folder_id = params[:folder_id].split('_').last
    asset_id = params[:asset_id].split('_').last
    if Folder.exists?(folder_id) && Asset.exists?(asset_id)
      folder = Folder.find(folder_id )
      if folder.client_id == session[:client_id]
        asset = Asset.find(asset_id)
        asset.folder_id = folder_id
        asset.position = 0
        asset.save
      end
    end
    render :nothing => true
  end
end