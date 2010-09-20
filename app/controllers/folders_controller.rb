class FoldersController < ApplicationController
  def index   
    @folders = Folder.find_all_by_client_id(session[:client_id])
  end
  def show    
    @folders = Folder.find_all_by_client_id(session[:client_id])
    if Folder.exists?(params[:id])
      @folder = Folder.find(params[:id])
      if @folder.client_id != session[:client_id]
        redirect_to folders_url, :notice => 'You are not allowed to access that folder.'
      end
    else
      redirect_to folders_url, :notice => 'That folder does not exist.'
    end
  end
  def new     
    @folder = Folder.new
    render 'form'
  end
  def edit    
    if Folder.exists?(params[:id])
      @folder = Folder.find(params[:id])
      if @folder.client_id == session[:client_id]
        render 'form'
      else
        redirect_to folders_url, :notice => 'You are not allowed to edit that folder.'
      end
    else
      redirect_to folders_url, :notice => 'That folder does not exist.'
    end
  end
  def create  
    @folder = Folder.new(params[:folder])
    @folder[:client_id] = session[:client_id]
    flash[:notice] = 'Folder was successfully created.'
    
    if @folder.save && params[:continue] == nil
      redirect_to @folder
    else
      render 'form'
    end
  end
  def update  
    if Folder.exists?(params[:id])
      @folder = Folder.find(params[:id])
      if @folder.client_id == session[:client_id]
        flash[:notice] = 'Folder was successfully updated.'
        if @folder.update_attributes(params[:folder]) && params[:continue] == nil
          redirect_to @folder
        else
          render 'form'
        end
      else
        redirect_to folders_url, :notice => 'You are not allowed to update that folder.'
      end
    else
      redirect_to folders_url, :notice => 'That folder does not exist.'
    end
  end
  def destroy 
    if Folder.exists?(params[:id])
      @folder = Folder.find(params[:id])
      if @folder.client_id == session[:client_id]
        @folder.destroy
        notice = 'Folder was destroyed.'
      else
        notice = 'You are not allowed to destroy that folder.'
      end
    else
      notice = 'That folder does not exist.'
    end
    redirect_to folders_url, :notice => notice
  end
end