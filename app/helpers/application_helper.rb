module ApplicationHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def vote_char(wish)
    if current_user && wish.voted_by?(current_user)
      "-"
    else
      "+"
    end
  end

  def poly_wish_url(wish)
    polymorphic_url(wish, :subdomain => wish.issue.permalink) 
  end
  
end
