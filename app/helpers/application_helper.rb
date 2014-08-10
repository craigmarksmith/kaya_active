module ApplicationHelper
  def homepage?
  	current_page? action: :index, controller: :landing
  end
end
