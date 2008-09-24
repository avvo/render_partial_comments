# these should all be defined...
ActionView::Base
  
class ActionView::Base
  
  private
  
  $render_partial_comments ||= false
  
  # render_partial(partial_path, object_assigns = nil, local_assigns = {})
  def render_partial_with_comments(partial_path, object_assigns = nil, local_assigns = {})
    if $render_partial_comments
      r = %{<!-- render_begin '#{partial_path}' -->}
      r << render_partial_without_comments(partial_path, object_assigns, local_assigns)
      r << %{<!-- render_end '#{partial_path}' -->}
      r
    else
      render_partial_without_comments(partial_path, object_assigns, local_assigns)
    end
  end

  alias_method :render_partial_without_comments, :render_partial
  alias_method :render_partial, :render_partial_with_comments
end