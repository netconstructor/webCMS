class GroupsController < ApplicationController
  def index   
    @groups = Group.find_all_by_client_id(session[:client_id])
  end
  def show    
    @groups = Group.find_all_by_client_id(session[:client_id])
    if Group.exists?(params[:id])
      @group = Group.find(params[:id])
      if @group.client_id != session[:client_id]
        redirect_to groups_url, :notice => 'You are not allowed to access that group.'
      end
    else
      redirect_to groups_url, :notice => 'That group does not exist.'
    end
  end
  def new     
    @group = Group.new
    render 'form'
  end
  def edit    
    if Group.exists?(params[:id])
      @group = Group.find(params[:id])
      if @group.client_id == session[:client_id]
        render 'form'
      else
        redirect_to groups_url, :notice => 'You are not allowed to edit that group.'
      end
    else
      redirect_to groups_url, :notice => 'That group does not exist.'
    end
  end
  def create  
    if params[:group][:admin] == '1'
      params[:group][:page_ids] = []
    end  
    @group = Group.new(params[:group])
    @group[:client_id] = session[:client_id]
    flash[:notice] = 'Group was successfully created.'
    
    if @group.save && params[:continue] == nil
      redirect_to @group
    else
      render 'form'
    end
  end
  def update  
    params[:group][:page_ids] ||= []
    if params[:group][:admin] == '1'
      params[:group][:page_ids] = []
    end
    if Group.exists?(params[:id])
      @group = Group.find(params[:id])
      if @group.client_id == session[:client_id]
        flash[:notice] = 'Group was successfully updated.'
        if @group.update_attributes(params[:group]) && params[:continue] == nil
          redirect_to @group
        else
          render 'form'
        end
      else
        redirect_to groups_url, :notice => 'You are not allowed to update that group.'
      end
    else
      redirect_to groups_url, :notice => 'That group does not exist.'
    end
  end
  def destroy 
    if Group.exists?(params[:id])
      @group = Group.find(params[:id])
      if @group.client_id == session[:client_id]
        @group.destroy
        notice = 'Group was destroyed.'
      else
        notice = 'You are not allowed to destroy that group.'
      end
    else
      notice = 'That group does not exist.'
    end
    redirect_to groups_url, :notice => notice
  end
end