class DialogsController < ApplicationController
  layout nil
  def show 
    render :json => { :error => false, :url => 'assets/photos/5/small.jpg', :width => 300, :height => 300 }
  end
end
