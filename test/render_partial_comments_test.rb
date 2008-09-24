require 'test/unit'

# first defined some stubs...
module ActionView; end;

class ActionView::Base
  
  def render_partial_wrapper(partial_path)
    render_partial(partial_path)
  end
  
  private
  
  def render_partial(partial_path, object_assigns = nil, local_assigns = {})
    "<b>Some junk html</b>"
  end
  
end


require File.join(File.dirname(__FILE__), '../lib', 'render_partial_comments')

class RenderPartialCommentsTest < Test::Unit::TestCase

  def test_disabled
    a = ActionView::Base.new
    $render_partial_comments = false
    
    r = a.render_partial_wrapper('user/view')
    assert_equal("<b>Some junk html</b>", r)    
  end
  
  def test_enabled
    a = ActionView::Base.new
    $render_partial_comments = true
    
    r = a.render_partial_wrapper('user/view')
    assert_equal("<!-- render_begin 'user/view' --><b>Some junk html</b><!-- render_end 'user/view' -->", r)
  end

end
