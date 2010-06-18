module IssuesHelper
  def link_to_show_wishes(issue)
    url = "http://#{issue.permalink}.#{$HOST_NAME}:3000"
    link_to issue.permalink, url 
  end
end
