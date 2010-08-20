module RoutingHelper

  def wish_url_with_subdomain(wish)
    polymorphic_url(wish, :subdomain => wish.issue.permalink)
  end

  def issue_url_with_subdomain(issue)
    root_url(:subdomain => issue.permalink)
  end

end
