# these should all be defined...
ActionView::Base
  
class ActionView::Base
  
  private
  
  $render_partial_comments ||= false
  
  # don't even define this method if we don't want it enabled (that way there is no
  # overhead in non-development environments
  if $render_partial_comments

    # render_partial(partial_path, object_assigns = nil, local_assigns = {})
    def render_partial_with_comments(partial_path, object_assigns = nil, local_assigns = {})
      r = %{<!-- render_begin '#{partial_path}' -->}
      r << render_partial_without_comments(partial_path, object_assigns, local_assigns)
      r << %{<!-- render_end '#{partial_path}' -->}
      r
    end

    alias_method_chain :render_partial, :comments
    
  end
end