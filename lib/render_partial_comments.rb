# these should all be defined...
ActionView::Base
  
module ActionView::Base
   
  private

  def self.perform_partial_comments?
    # TODO: make this some kind of configuration in environments
    RAILS_ENV == 'development'
  end
  
  # don't even define this method if we don't want to 
  if preform_partial_comments?

    # render_partial(partial_path, object_assigns = nil, local_assigns = {})
    def render_partial_with_comments(partial_path, object_assigns = nil, local_assigns = {})
      r = ''    
      r << %{<!-- render_start '#{template_path}' -->} if self.class.perform_partial_comments?    
      r << render_for_file_without_comments(template_path, state, layout, locals)
      r << %{<!-- render_end '#{template_path}' -->} if self.class.perform_partial_comments?
      r
    end

    alias_method_chain :render_partial, :comments
  end
end