module ApplicationHelper
  def link_to_edit    (element)
    link_to image_tag("/images/refinery/icons/application_edit.png", :border => 0), self.send("edit_#{element.class.to_s.downcase}_path", element), :title => "Edit this #{element.class.to_s.downcase}"
  end
  def link_to_delete  (element)
    link_to image_tag("/images/refinery/icons/delete.png", :border => 0), element, :confirm => 'Are you sure?', :method => :delete, :title=> "Remove this #{element.class.to_s.downcase} forever"
  end
  def link_to_show    (element)
    link_to image_tag("/images/refinery/icons/eye.png", :border => 0), element, :title=> "Show this #{element.class.to_s.downcase}"
  end

  def item    (f, type, name)
    render :partial => "shared/form/#{type}", :locals => {:f => f, :name => name}
  end
  def buttons (f, controller, buttons, item = nil)
    render :partial => 'shared/form/buttons', :locals => {:f => f, :controller => controller, :buttons => buttons, :item => item}
  end
end