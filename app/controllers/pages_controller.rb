class PagesController < ApplicationController
  def index   
    @pages = Page.find_all_by_parent_id(nil, :conditions => {:client_id => session[:client_id]})
  end
  def show    
    if Page.exists?(params[:id])
      @page = Page.find(params[:id])
      @parts = Part.find_all_by_client_id(session[:client_id])
      if @page.client_id != session[:client_id]
        redirect_to pages_url, :notice => 'You are not allowed to access that page.'
      end
    else
      redirect_to pages_url, :notice => 'That page does not exist.'
    end
  end
  def new     
    @page = Page.new
    @parts = Part.find_all_by_client_id(session[:client_id])
    render 'form'
  end
  def edit    
    if Page.exists?(params[:id])
      @page = Page.find(params[:id])
      if @page.client_id == session[:client_id]
        @parts = Part.find_all_by_client_id(session[:client_id])
        render 'form'
      else
        redirect_to pages_url, :notice => 'You are not allowed to edit that page.'
      end
    else
      redirect_to pages_url, :notice => 'That page does not exist.'
    end
  end
  def create  
    @page = Page.new(params[:page])
    @page[:client_id] = session[:client_id]
    @page[:parent_id] = nil
    @page.position = 1
    flash[:notice] = 'Page was successfully created.'
    if @page.save && params[:continue] == nil
      redirect_to pages_url
    else
      render 'form'
    end
  end
  def update  
    if Page.exists?(params[:id])
      @page = Page.find(params[:id])
      if @page.client_id == session[:client_id]
        flash[:notice] = 'Page was successfully updated.'
        if @page.update_attributes(params[:page]) && params[:continue] == nil
          redirect_to pages_url
        else
          render 'form'
        end
      else
        redirect_to pages_url, :notice => 'You are not allowed to update that page.'
      end
    else
      redirect_to pages_url, :notice => 'That page does not exist.'
    end
  end
  def destroy 
    if Page.exists?(params[:id])
      @page = Page.find(params[:id])
      if @page.client_id == session[:client_id]
        @page.destroy
        notice = 'Page was destroyed.'
      else
        notice = 'You are not allowed to destroy that page.'
      end
    else
      notice = 'That page does not exist.'
    end
    redirect_to pages_url, :notice => notice
  end
  def move    
    id = params[:id].split('_').last
    position = params[:position].to_i
    ref = params[:ref] != 'records' ? params[:ref].split('_').last : nil
    if Page.exists?(id)
      @page = Page.find(id)
      if @page.client_id == session[:client_id]
        if @page.parent_id.to_s == ref.to_s
          @page.insert_at @page.position < position ? position : position+1
        else
          @page.remove_from_list
          @page.parent_id = ref
          @page.save
          @page.reload
          @page.insert_at position+1
        end
        @page.save
      end
    end
    render :nothing => true
  end
end