class UsersController < ApplicationController
  def new     
    @user = User.new
    @user.group_id = params[:group_id]
    render 'form'
  end
  def edit    
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      if @user.group.client_id == session[:client_id]
        render 'form'
      else
        redirect_to groups_url, :notice => 'You are not allowed to edit that user.' 
      end
    else
      redirect_to groups_url, :notice => 'That user does not exist.'
    end
  end
  def create  
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      if params[:continue] == nil
        redirect_to @user.group
      else
        render 'form'
      end
    else
      render 'form'
    end
  end
  def update  
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      if @user.group.client_id == session[:client_id]
        if @user.update_attributes(params[:user])
          flash[:notice] = 'User was successfully updated.'
          if params[:continue] == nil
            redirect_to group_path(@user.group_id)
          else
            render 'form'
          end
        else
          render 'form'
        end
      else
        redirect_to groups_url, :notice => 'You are not allowed to update that user.'
      end
    else
      redirect_to groups_url, :notice => 'That user does not exist.'
    end
  end
  def destroy 
    id = params[:id].split('_').last 
    if User.exists?(id)
      @user = User.find(id)
      if @user.group.client_id == session[:client_id]
        @user.destroy
      end
    end
    render :nothing => true
  end
  def drop    
    group_id = params[:group_id].split('_').last
    user_id = params[:user_id].split('_').last
    if Group.exists?(group_id) && User.exists?(user_id)
      group = Group.find(group_id )
      if group.client_id == session[:client_id]
        user = User.find(user_id)
        user.group_id = group_id
        user.save
      end
    end
    render :nothing => true
  end
end