class ItemsController < ApplicationController
  def new     
    @item = Item.new
    @item.page_id = params[:page_id]
    @item.part_id = params[:part_id]
    if Dir.entries("#{Rails.root}/app/views/items/forms/").include?("_#{params[:type]}.erb")
      @item.link = Article.new
      render 'form'
    else
      redirect_to page_path(@item.page_id), :notice => 'Something went wrong. Maybe there is a bug in the system.'
    end
  end
  def edit    
    if Item.exists?(params[:id])
      @item = Item.find(params[:id])
      if @item.page.client_id == session[:client_id]
        render 'form'
      else
       redirect_to pages_url, :notice => 'You are not allowed to edit that page.' 
      end
    else
      redirect_to pages_url, :notice => 'That item does not exist.'
    end
  end
  def create  
    @item = Item.new(params[:item])
    flash[:notice] = 'Item was successfully created.'
    if @item.save && params[:continue] == nil
      redirect_to page_path(item.page_id)
    else
      render 'form'
    end
  end
  def update  
    if Item.exists?(params[:id])
      @item = Item.find(params[:id])
      if @item.page.client_id == session[:client_id]
        flash[:notice] = 'Item was successfully updated.'
        if @item.update_attributes(params[:item]) && params[:continue] == nil
          redirect_to page_path(@item.page_id)
        else
          render 'form'
        end
      else
        redirect_to pages_url, :notice => 'You are not allowed to update that page.'
      end
    else
      redirect_to pages_url, :notice => 'That item does not exist.'
    end
  end
  def destroy 
    if Item.exists?(params[:id])
      @item = Item.find(params[:id])
      if @item.page.client_id == session[:client_id]
        @item.destroy
        notice = 'Item was destroyed.'
      else
        notice = 'You are not allowed to destroy that item.'
      end
    else
      notice = 'That item does not exist.'
    end
    redirect_to page_path(@item.page_id), :notice => 'Item was destroyed.'
  end
end