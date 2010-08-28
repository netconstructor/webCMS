class ClientsController < ApplicationController
  def index   
    @clients = Client.all
  end
  def new     
    @client = Client.new
    render 'form'
  end
  def edit    
    @client = Client.find(params[:id])
    render 'form'
  end
  def create  
    $file = params['file']
    @client = Client.new(params[:client])
    flash[:notice] = 'Client was successfully created.'
    
    if @client.save && params[:continue] == nil
      redirect_to clients_url
    else
      render 'form'
    end
  end
  def update  
    $file = params['file']
    @client = Client.find(params[:id])
    flash[:notice] = 'Client was successfully updated.'
    
    if @client.update_attributes(params[:client]) && params[:continue] == nil
      redirect_to clients_url
    else
      render 'form'
    end
  end
  def destroy 
    @client = Client.find(params[:id])
    @client.destroy
    
    redirect_to clients_url, :notice => 'Client was destroyed.'
  end
  def change  
    session[:client_id] = params[:id].to_i if Client.exists?(params[:id])
    redirect_to clients_url, :notice => 'Client was changed'
  end
end